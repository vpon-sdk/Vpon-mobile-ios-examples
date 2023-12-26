//
//  VponSdkInterstitialViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/7/18.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkInterstitialViewController.h"

@import VpadnSDKAdKit;
@import AdSupport;

@interface VponSdkInterstitialViewController () <VponFullScreenContentDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) VponInterstitialAd *interstitial;

@end

@implementation VponSdkInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

// MARK: - Create VponAdRequest

- (VponAdRequest *) createRequest {
    VponAdRequest *request = [[VponAdRequest alloc] init];
    [request setUserInfoGender:VponUserGenderMale]; // 性別
    [request setUserInfoBirthdayWithYear:2000 month:8 day:17]; // 生日
    [request setContentUrl:@"https://www.vpon.com.tw/"]; // 內容
    [request setContentData:@{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)}]; // 內容鍵值
   
    VponAdRequestConfiguration *config = VponAdRequestConfiguration.shared;
    [config setTestDeviceIdentifiers:@[[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString]]; // 取得測試廣告
    [config setTagForUnderAgeOfConsent:VponTagForUnderAgeOfConsentNotForUnderAgeOfConsent]; // 是否專為特定年齡投放
    [config setTagForChildDirectedTreatment:VponTagForChildDirectedTreatmentNotForChildDirectedTreatment]; // 是否專為兒童投放
    [config setMaxAdContentRating:VponMaxAdContentRatingGeneral]; // 最高可投放的年齡(分類)限制
  
    return request;
}

// MARK: - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    if (_interstitial != nil) {
        [_interstitial presentFromRootViewController:self];
    } else {
        [VponInterstitialAd loadWithLicenseKey:@""
                                       request:[self createRequest]
                                    completion:^(VponInterstitialAd *interstitial, NSError *error) {
            
            self.interstitial = interstitial;
            self.interstitial.delegate = self;
            
            if (error != nil) {
                NSLog(@"Failed to load ad with error: %@", error.localizedDescription);
                self.actionButton.enabled = YES;
                [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
                return;
            }
            
            self.interstitial = interstitial;
            self.interstitial.delegate = self;
            
            if (_interstitial != nil) {
                NSLog(@"Received ad successfully");
                self.actionButton.enabled = YES;
                [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
            }
        }];
    }
}

// MARK: - VponFullScreenContentDelegate

- (void)adWillPresentScreen:(id<VponFullScreenContentAd>)ad {
    NSLog(@"Ad will present full screen content.");
}

- (void)ad:(id<VponFullScreenContentAd>)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
    NSLog(@"Ad did fail to present full screen content with error: %@", error.localizedDescription);
}

- (void)adWillDismissScreen:(id<VponFullScreenContentAd>)ad {
    NSLog(@"Ad will dismiss full screen content.");
}

- (void)adDidDismissScreen:(id<VponFullScreenContentAd>)ad {
    NSLog(@"Ad did dismiss full screen content.");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void)adDidRecordImpression:(id<VponFullScreenContentAd>)ad {
    NSLog(@"Ad did record an impression.");
}

- (void)adDidRecordClick:(id<VponFullScreenContentAd>)ad {
    NSLog(@"Ad did record a click.");
}

@end

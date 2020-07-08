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

@interface VponSdkInterstitialViewController () <VpadnInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) VpadnInterstitial *vpadnInterstitial;

@end

@implementation VponSdkInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial VpadnAdRequest

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    [request setTestDevices:@[[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString]];   //取得測試廣告
    [request setUserInfoGender:VpadnGenderMale];                                                        //性別
    [request setUserInfoBirthdayWithYear:2000 Month:8 andDay:17];                                       //生日
    [request setMaxAdContentRating:VpadnMaxAdContentRatingGeneral];                                     //最高可投放的年齡(分類)限制
    [request setTagForUnderAgeOfConsent:VpadnTagForUnderAgeOfConsentFalse];                             //是否專為特定年齡投放
    [request setTagForChildDirectedTreatment:VpadnTagForChildDirectedTreatmentFalse];                   //是否專為兒童投放
    [request setContentUrl:@"https://www.vpon.com.tw/"];
    [request setContentData:@{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)}];
    return request;
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    if (_vpadnInterstitial != nil && _vpadnInterstitial.isReady) {
        [_vpadnInterstitial showFromRootViewController:self];
    } else {
        _vpadnInterstitial = [[VpadnInterstitial alloc] initWithLicenseKey:@"8a80854b6a90b5bc016ad81a98cf652e"];
        _vpadnInterstitial.delegate = self;
        [_vpadnInterstitial loadRequest:[self initialRequest]];
    }
}

#pragma mark - Vpadn Interstitial Delegate

/// 通知有廣告可供拉取 call back
- (void) onVpadnInterstitialLoaded:(VpadnInterstitial *)interstitial {
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnInterstitial:(VpadnInterstitial *)interstitial failedToLoad:(NSError *)error {
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

/// 通知即將離開Application
- (void) onVpadnInterstitialWillLeaveApplication:(VpadnInterstitial *)interstitial {
    
}

/// 通知廣告即將被開啟
- (void) onVpadnInterstitialWillOpen:(VpadnInterstitial *)interstitial {
    
}

/// 通知廣告已被關閉
- (void) onVpadnInterstitialClosed:(VpadnInterstitial *)interstitial {
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

/// 通知廣告已送出點擊事件
- (void) onVpadnInterstitialClicked:(VpadnInterstitial *)interstitial {
    
}

@end

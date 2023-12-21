//
//  VponSdkBannerViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/7/18.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkBannerViewController.h"

@import VpadnSDKAdKit;
@import AdSupport;

@interface VponSdkBannerViewController () <VponBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) VponBannerView *bannerView;

@end

@implementation VponSdkBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - Banner";
    [self requestButtonDidTouch:self.requestButton];
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

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    _bannerView = [[VponBannerView alloc]initWithAdSize:[VponAdSize banner]];
    _bannerView.licenseKey = @"";
    _bannerView.rootViewController = self;
    _bannerView.delegate = self;
    [_bannerView load: [self createRequest]];
}

// MARK: - VponBannerViewDelegate

- (void)bannerViewDidReceiveAd:(VponBannerView *)bannerView {
    // Invoked if receive Banner Ad successfully
    
    NSLog(@"bannerViewDidReceiveAd");
    
    for (UIView *view in self.loadBannerView.subviews) {
        [view removeFromSuperview];
    }
    
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loadBannerView addSubview:bannerView];
    
    [NSLayoutConstraint activateConstraints:@[
        [bannerView.centerXAnchor constraintEqualToAnchor: _loadBannerView.centerXAnchor],
        [bannerView.centerYAnchor constraintEqualToAnchor: _loadBannerView.centerYAnchor]
    ]];
    
    self.requestButton.enabled = YES;
}

- (void)bannerView:(VponBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    // Invoked if received ad fail, check this callback to indicates what type of failure occurred
    
    NSLog(@"bannerView didFailToReceiveAdWithError: %@", error.localizedDescription);
    self.requestButton.enabled = YES;
}

- (void)bannerViewDidRecordImpression:(VponBannerView *)bannerView {
    // Invoked if an impression has been recorded for an ad.
    
    NSLog(@"bannerViewDidRecordImpression");
}

- (void)bannerViewDidRecordClick:(VponBannerView *)bannerView {
    // Invoked if an click has been recorded for an ad.
    
    NSLog(@"bannerViewDidRecordClick");
}

@end

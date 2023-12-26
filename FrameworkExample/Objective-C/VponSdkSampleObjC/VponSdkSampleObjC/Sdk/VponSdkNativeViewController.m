//
//  VponSdkNativeViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2020/1/20.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "VponSdkNativeViewController.h"
#import <VpadnSDKAdKit/VpadnSDKAdKit.h>
#import <AdSupport/AdSupport.h>

@interface VponSdkNativeViewController () <VponNativeAdLoaderDelegate, VponNativeAdDelegate, VponVideoControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (strong, nonatomic) VponNativeAdLoader *adLoader;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property(nonatomic, strong) VponNativeAdView *nativeAdView;

@end

@implementation VponSdkNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - Native";
    
    _nativeAdView = [[NSBundle mainBundle] loadNibNamed:@"NativeAdView" owner:nil options:nil]
        .firstObject;
    [_adContainerView addSubview:_nativeAdView];
    _nativeAdView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [_nativeAdView.heightAnchor constraintEqualToAnchor: _adContainerView.heightAnchor],
        [_nativeAdView.widthAnchor constraintEqualToAnchor: _adContainerView.widthAnchor]
    ]];
    
    [self requestButtonDidTouch:_requestButton];
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
    
    _adLoader = [[VponNativeAdLoader alloc]initWithLicenseKey:@"" rootViewController:self];
    _adLoader.delegate = self;
    [_adLoader load:[self createRequest]];
}

// MARK: - VponNativeAdLoaderDelegate

- (void)adLoader:(VponNativeAdLoader *)adLoader didReceive:(VponNativeAd *)nativeAd {
    NSLog(@"adLoader didReceive nativeAd");
    _requestButton.enabled = YES;
    
    nativeAd.delegate = self;
    
    ((UILabel *)_nativeAdView.headlineView).text = nativeAd.headline;
    _nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    
    if (nativeAd.mediaContent.hasVideoContent) {
        nativeAd.mediaContent.videoController.delegate = self;
    }
    
    ((UILabel *)_nativeAdView.bodyView).text = nativeAd.body;
    [((UIButton *)_nativeAdView.callToActionView) setTitle:nativeAd.callToAction
                                                  forState:UIControlStateNormal];
    ((UIImageView *)_nativeAdView.iconView).image = nativeAd.icon.image;
    
    // Necessary to show media content and make it clickable!
    _nativeAdView.nativeAd = nativeAd;
}

- (void)adLoader:(VponNativeAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"adLoader didFailToReceiveAdWithError: %@", error.localizedDescription);
    _requestButton.enabled = YES;
}

// MARK: - VponNativeAdDelegate

- (void)nativeAdDidRecordImpression:(VponNativeAd *)nativeAd {
    NSLog(@"nativeAdDidRecordImpression");
}

- (void)nativeAdDidRecordClick:(VponNativeAd *)nativeAd {
    NSLog(@"nativeAdDidRecordClick");
}

// MARK: - VponVideoControllerDelegate

- (void)videoControllerDidPlayVideo:(VponVideoController *)videoController {
    NSLog(@"videoControllerDidPlayVideo");
}

- (void)videoControllerDidPauseVideo:(VponVideoController *)videoController {
    NSLog(@"videoControllerDidPauseVideo");
}

- (void)videoControllerDidMuteVideo:(VponVideoController *)videoController {
    NSLog(@"videoControllerDidMuteVideo");
}

- (void)videoControllerDidUnmuteVideo:(VponVideoController *)videoController {
    NSLog(@"videoControllerDidUnmuteVideo");
}

- (void)videoControllerDidEndVideoPlayback:(VponVideoController *)videoController {
    NSLog(@"videoControllerDidEndVideoPlayback");
}

@end

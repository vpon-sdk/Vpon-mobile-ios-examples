//
//  VponSdkNativeViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2020/1/20.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "VponSdkNativeViewController.h"

@import VpadnSDKAdKit;
@import AdSupport;

@interface VponSdkNativeViewController () <VpadnMediaViewDelegate, VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAd *nativeAd;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;
@property (weak, nonatomic) IBOutlet UIButton *adAction;
@property (weak, nonatomic) IBOutlet VpadnMediaView *adMediaView;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end

@implementation VponSdkNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - Native";
    [self requestButtonDidTouch:_requestButton];
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

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    
    if (_nativeAd) {
        [_nativeAd unregisterView];
    }
    
    _nativeAd = [[VpadnNativeAd alloc] initWithLicenseKey:@"8a80854b6a90b5bc016ad81ac68c6530"];
    _nativeAd.delegate = self;
    [_nativeAd loadRequest:[self initialRequest]];
}

- (void)setNativeAd {
    _adIcon.image = nil;
    
    __block typeof(self) safeSelf = self;
    [_nativeAd.icon loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
        safeSelf.adIcon.image = image;
    }];
    
    [_adMediaView setNativeAd:_nativeAd];
    _adMediaView.delegate = self;
    
    _adTitle.text = [_nativeAd.title copy];
    _adBody.text = [_nativeAd.body copy];
    _adSocialContext.text = [_nativeAd.socialContext copy];
    [_adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateNormal];
    [_adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateHighlighted];
    
    [_nativeAd registerViewForInteraction:_contentView withViewController:self];
}

#pragma mark - VpadnNativeAd Delegate

/// 通知有廣告可供拉取 call back
- (void) onVpadnNativeAdLoaded:(VpadnNativeAd *)nativeAd {
    _requestButton.enabled = YES;
    [self setNativeAd];
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd failedToLoad:(NSError *)error {
    
    _requestButton.enabled = YES;
}

/// 通知即將離開Application
- (void) onVpadnNativeAdWillLeaveApplication:(VpadnNativeAd *)nativeAd {
    
}

/// 通知廣告已送出點擊事件
- (void) onVpadnNativeAdClicked:(VpadnNativeAd *)nativeAd {
    
}

#pragma mark - VpadnMediaView Delegate

- (void) mediaViewDidLoad:(VpadnMediaView *)mediaView {
    
}

- (void) mediaViewDidFailed:(VpadnMediaView *)mediaView error:(NSError *)error {
    
}

@end

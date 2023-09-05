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

@interface VponSdkBannerViewController () <VpadnBannerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@end

@implementation VponSdkBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - Banner";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Initial VpadnAdRequest

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    [request setTestDevices:@[[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString]];   //取得測試廣告
    [request setUserInfoGender: VpadnUserGenderUnspecified];                                            //性別
    [request setUserInfoBirthdayWithYear:2000 month:8 day:17];                                          //生日
    [request setTagForMaxAdContentRating:VpadnMaxAdContentRatingUnspecified];                           //最高可投放的年齡(分類)限制
    [request setTagForUnderAgeOfConsent:VpadnTagForUnderAgeOfConsentUnspecified];                       //是否專為特定年齡投放
    [request setTagForChildDirectedTreatment:VpadnTagForChildDirectedTreatmentUnspecified];             //是否專為兒童投放
    [request setContentUrl:@"https://www.vpon.com.tw/"];
    [request setContentData:@{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)}];
    [request addFriendlyObstruction:[[UIView alloc] init] purpose:VpadnFriendlyObstructionTypeNotVisible description:@"not visible"];
    return request;
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    if (_vpadnBanner != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_vpadnBanner.getVpadnAdView removeFromSuperview];
        });
    }
    _vpadnBanner = [[VpadnBanner alloc]initWithLicenseKey:@"" adSize:VpadnAdSize.banner];
    _vpadnBanner.delegate = self;
    [_vpadnBanner loadRequest:[self initialRequest]];
}

#pragma mark - Vpadn Banner Delegate

/// 通知有廣告可供拉取 call back
- (void) onVpadnAdLoaded:(VpadnBanner *)banner {
    [self.loadBannerView addSubview:banner.getVpadnAdView];
    self.requestButton.enabled = YES;
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnAd:(VpadnBanner *)banner failedToLoad:(NSError *)error {
    self.requestButton.enabled = YES;
}

/// 通知即將離開 application
- (void) onVpadnAdWillLeaveApplication:(VpadnBanner *)banner {
    
}

/// 通知廣告已送出點擊事件
- (void) onVpadnAdClicked:(VpadnBanner *)banner {
    
}

/// 通知廣告將自動 refresh
- (void) onVpadnAdRefreshed:(VpadnBanner *)banner {
    
}

@end

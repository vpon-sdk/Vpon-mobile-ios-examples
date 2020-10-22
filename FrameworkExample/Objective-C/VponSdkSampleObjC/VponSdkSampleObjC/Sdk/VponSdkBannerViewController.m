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
    [request setUserInfoGender:VpadnGenderMale];                                                        //性別
    [request setUserInfoBirthdayWithYear:2000 Month:8 andDay:17];                                       //生日
    [request setMaxAdContentRating:VpadnMaxAdContentRatingGeneral];                                     //最高可投放的年齡(分類)限制
    [request setTagForUnderAgeOfConsent:VpadnTagForUnderAgeOfConsentFalse];                             //是否專為特定年齡投放
    [request setTagForChildDirectedTreatment:VpadnTagForChildDirectedTreatmentFalse];                   //是否專為兒童投放
    [request setContentUrl:@"https://www.vpon.com.tw/"];
    [request setContentData:@{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)}];
//    [request addFriendlyObstruction:[[UIView alloc] init] purpose:VpadnFriendlyObstructionNotVisible description:@"not visible"];
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
    _vpadnBanner = [[VpadnBanner alloc] initWithLicenseKey:@"8a80854b6a90b5bc016ad81a5059652d" adSize:VpadnAdSizeSmartBannerPortrait];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

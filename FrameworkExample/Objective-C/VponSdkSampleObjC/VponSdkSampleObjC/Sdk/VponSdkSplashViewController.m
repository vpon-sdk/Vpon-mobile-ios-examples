//
//  VponSdkSplashViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/11/29.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkSplashViewController.h"

@import VpadnSDKAdKit;
@import AdSupport;

@interface VponSdkSplashViewController () <VpadnSplashDelegate>

@property (weak, nonatomic) IBOutlet UIView *loadSplashView;

@property (strong, nonatomic) VpadnSplash *vpadnSplash;

@property (weak, nonatomic) IBOutlet  UIButton *requestButton;

@end

@implementation VponSdkSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - Splash";
    [self requestButtonDidTouch:_requestButton];
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

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    _vpadnSplash = [[VpadnSplash alloc] initWithLicenseKey:@"8a80854b62d1fdc40162d205d0ff0005" target:_loadSplashView];
    _vpadnSplash.delegate = self;
    [_vpadnSplash setEndurableSecond:3];
    [_vpadnSplash loadRequest:[self initialRequest]];
}

#pragma mark -

/// 通知有廣告可供拉取 call back
- (void) onVpadnSplashLoaded:(VpadnSplash *)vpadnSplash {
    _requestButton.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnSplash:(VpadnSplash *)vpadnSplash failedToLoad:(NSError *)error {
    _requestButton.enabled = YES;
}

/// 通知廣告已送出點擊事件
- (void) onVpadnSplashClicked:(VpadnSplash *)vpadnSplash {
    
}

/// 通知即將離開Application
- (void) onVpadnSplashWillLeaveApplication:(VpadnSplash *)vpadnSplash {
    
}

/// 通知廣告被允許關閉
- (void) onVpadnSplashAllowToClose:(VpadnSplash *)vpadnSplash {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

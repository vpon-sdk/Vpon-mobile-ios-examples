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
    [request addKeyword:@"keywordA"];                                                                   //關鍵字
    [request addKeyword:@"key1:value1"];                                                                //鍵值
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
/// 通知廣告已取得且呈現
- (void)onVpadnSplashReceived:(nonnull VpadnSplash *)vpadnSplash {
    _requestButton.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
/// 通知廣告取得失敗
- (void)onVpadnSplash:(nonnull VpadnSplash *)vpadnSplash didFailToReceiveAdWithError:(nullable NSError *)error{
    _requestButton.enabled = YES;
}
/// 通知可以關閉廣告
- (void)onVpadnSplashAllowToDismiss:(nonnull VpadnSplash *)vpadnSplash{
    [self.navigationController popViewControllerAnimated:YES];
}
/// 通知廣告被點擊
- (void)onVpadnSplashClicked:(nonnull VpadnSplash *)vpadnSplash{
    
}
/// 通知即將離開App
- (void)onVpadnSplashLeaveApplication:(nonnull VpadnSplash *)vpadnSplash{
    
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

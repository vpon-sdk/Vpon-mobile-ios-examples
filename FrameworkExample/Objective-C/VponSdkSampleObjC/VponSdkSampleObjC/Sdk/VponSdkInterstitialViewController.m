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
    [request addKeyword:@"keywordA"];                                                                   //關鍵字
    [request addKeyword:@"key1:value1"];                                                                //鍵值
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

- (void) onVpadnInterstitialAdReceived:(UIView *)bannerView {
    NSLog(@"Received interstitial ad successfully");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void) onVpadnInterstitialAdFailed:(UIView *)bannerView {
    NSLog(@"Failed to receive interstitail");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void) onVpadnInterstitialAdWillPresent:(UIView *)bannerView {
    
}

- (void) onVpadnInterstitialAdWillDismiss:(UIView *)bannerView {
    
}

- (void) onVpadnInterstitialAdDismiss:(UIView *)bannerView {
    NSLog(@"Interstitial did dismiss screen");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void) onVpadnInterstitialAdWillLeaveApplication:(UIView *)bannerView {
    
}

- (void) onVpadnInterstitialAdClicked {
    
}

@end

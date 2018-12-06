//
//  VponSdkInterstitialViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/7/18.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkInterstitialViewController.h"

@import VpadnSDKAdKit;

@interface VponSdkInterstitialViewController () <VpadnInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic) BOOL isShow;

@property (strong, nonatomic) VpadnInterstitial *vpadnInterstitial;

@end

@implementation VponSdkInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShow = NO;
    self.title = @"SDK - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.vpadnInterstitial != nil && self.vpadnInterstitial.isReady && self.isShow) {
        [self.vpadnInterstitial show];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    self.isShow = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    if (self.vpadnInterstitial != nil && self.vpadnInterstitial.isReady) {
        [self.vpadnInterstitial show];
    } else {
        _vpadnInterstitial = [[VpadnInterstitial alloc] init];
#warning set ad banner id
        _vpadnInterstitial.strBannerId = @"8a80818242128afc014226580d4e0bf0";
        _vpadnInterstitial.platform = @"TW";
        _vpadnInterstitial.delegate = self;
        [_vpadnInterstitial setLocationOnOff:YES];
        [_vpadnInterstitial getInterstitial:@[]];
    }
}

- (IBAction)dismissButtonDidTouch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.vpadnInterstitial != nil && self.vpadnInterstitial.isReady) {
            [self.vpadnInterstitial show];
        }
    }];
}

#pragma mark - Vpadn Interstitial Delegate

- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView {
    NSLog(@"Received interstitial ad successfully");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView {
    NSLog(@"Failed to receive interstitail");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView {
    NSLog(@"Interstitial did dismiss screen");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
    _vpadnInterstitial = nil;
}

- (void)onVpadnInterstitialAdClicked {
    
}

@end

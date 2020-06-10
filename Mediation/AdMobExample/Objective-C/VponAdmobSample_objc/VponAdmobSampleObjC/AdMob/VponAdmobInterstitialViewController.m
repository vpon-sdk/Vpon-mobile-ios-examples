//
//  VponAdmobInterstitialViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponAdmobInterstitialViewController.h"

@import GoogleMobileAds;

@interface VponAdmobInterstitialViewController () <GADInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) GADInterstitial *gadInterstitialView;

@end

@implementation VponAdmobInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Admob - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.gadInterstitialView != nil && self.gadInterstitialView.isReady) {
        [self.gadInterstitialView presentFromRootViewController:self];
    } else {
        GADRequest *request = [GADRequest request];
//        GADExtras *extra = [[GADExtras alloc] init];
//        extra.additionalParameters = @{
//            @"contentURL": @"https://www.vpon.com",
//            @"contentData": @{@"key1": @"Admob - Interstitial", @"key2": @(1.2), @"key3": @(YES)}
//        };
//        [request registerAdNetworkExtras:extra];
//        request.testDevices = @[kGADSimulatorID];
        
        self.gadInterstitialView = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7987617251221645/3519729727"];
        self.gadInterstitialView.delegate = self;
        [self.gadInterstitialView loadRequest:request];
    }
}

#pragma mark - GADInterstitial Delegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"Received interstitial ad successfully");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive interstitail with error: %@", [error localizedFailureReason]);
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"Interstitial will present screen");
}

- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad {
    NSLog(@"Interstitial did fail to present screen");
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"Interstitial will dismiss screen");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"Interstitial did dismiss screen");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"Interstitial will leave application");
    
}

@end

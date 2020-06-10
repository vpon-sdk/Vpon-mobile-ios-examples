//
//  VponDFPInterstitialViewController.m
//  VponDFPSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponDFPInterstitialViewController.h"

@import GoogleMobileAds;

@interface VponDFPInterstitialViewController () <GADInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) DFPInterstitial *dfpInterstitialView;

@end

@implementation VponDFPInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DFP - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.dfpInterstitialView != nil && self.dfpInterstitialView.isReady) {
        [self.dfpInterstitialView presentFromRootViewController:self];
    } else {
        GADRequest *request = [GADRequest request];
        //    GADExtras *extra = [[GADExtras alloc] init];
        //    extra.additionalParameters = @{
        //        @"contentURL": @"https://www.vpon.com",
        //        @"contentData": @{@"key1": @"Admob", @"key2": @(1.2), @"key3": @(YES)}
        //    };
        //    [request registerAdNetworkExtras:extra];
        //    request.testDevices = @[kGADSimulatorID];
        
        self.dfpInterstitialView = [[DFPInterstitial alloc] initWithAdUnitID:@""];
        self.dfpInterstitialView.delegate = self;
        [self.dfpInterstitialView loadRequest:request];
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

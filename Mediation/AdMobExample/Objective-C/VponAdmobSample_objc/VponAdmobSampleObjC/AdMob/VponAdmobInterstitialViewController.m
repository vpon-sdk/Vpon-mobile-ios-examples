//
//  VponAdmobInterstitialViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponAdmobInterstitialViewController.h"

@import GoogleMobileAds;

@interface VponAdmobInterstitialViewController () <GADFullScreenContentDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) GADInterstitialAd *interstitialAd;

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
    
    GADRequest *request = [GADRequest request];
//    GADExtras *extra = [[GADExtras alloc] init];
//    extra.additionalParameters = @{
//        @"contentURL": @"https://www.vpon.com",
//        @"contentData": @{@"key1": @"Admob - Interstitial", @"key2": @(1.2), @"key3": @(YES)}
//    };
//    [request registerAdNetworkExtras:extra];
//    request.testDevices = @[kGADSimulatorID];
    
    __block __weak typeof(self) weakSelf = self;
    [GADInterstitialAd loadWithAdUnitID:@"ca-app-pub-7987617251221645/3519729727"
                                request:request
                      completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if (error != nil) {
            weakSelf.actionButton.enabled = YES;
            NSLog(@"Failed to receive interstitail with error: %@", [error localizedFailureReason]);
        }
    }];
}



#pragma mark - GADFullScreenContent Delegate

- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"Interstitial did present screen");
}

- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"Interstitial did dismiss screen");
    _interstitialAd = nil;
}

@end

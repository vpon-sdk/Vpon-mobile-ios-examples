//
//  VponAdmobBannerViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponAdmobBannerViewController.h"

@import GoogleMobileAds;

@interface VponAdmobBannerViewController () <GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) GADBannerView *gadBannerView;

@end

@implementation VponAdmobBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Admob - Banner";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.gadBannerView != nil) {
        [self.gadBannerView removeFromSuperview];
    }
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID];
    
    self.gadBannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(_loadBannerView.frame.size)];
    self.gadBannerView.adUnitID = @"";
    self.gadBannerView.delegate = self;
    self.gadBannerView.rootViewController = self;
    [self.gadBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"Received banner ad successfully");
    [self.loadBannerView addSubview:bannerView];
    self.requestButton.enabled = YES;
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive banner with error: %@", [error localizedFailureReason]);
    self.requestButton.enabled = YES;
}
@end

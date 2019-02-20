//
//  VponMopubBannerViewController.m
//  VponMopubSampleObjC
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponMopubBannerViewController.h"

#import <MoPub.h>
#import "MPVponBannerCustomEvent.h"

@interface VponMopubBannerViewController () <MPAdViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) MPAdView *mpBannerView;

@end

@implementation VponMopubBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MoPub - Banner";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.mpBannerView != nil) {
        [self.mpBannerView removeFromSuperview];
    }
    #warning set ad unit id
    self.mpBannerView = [[MPAdView alloc] initWithAdUnitId:@"782ad2f7565e4241a51045a523f5e12d" size:MOPUB_BANNER_SIZE];
    self.mpBannerView.delegate = self;
    [self.mpBannerView loadAd];
}

#pragma mark - MPAdView Delegate

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view {
    NSLog(@"Received banner ad successfully");
    [self.loadBannerView addSubview:view];
    self.requestButton.enabled = YES;
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    NSLog(@"Failed to receive banner");
    self.requestButton.enabled = YES;
}

- (void)willPresentModalViewForAd:(MPAdView *)view {
    NSLog(@"MoPub Banner will present screen");
}

- (void)didDismissModalViewForAd:(MPAdView *)view {
    NSLog(@"MoPub Banner did dismiss");
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view {
    NSLog(@"MoPub Banner will leave publisher application");
}

@end

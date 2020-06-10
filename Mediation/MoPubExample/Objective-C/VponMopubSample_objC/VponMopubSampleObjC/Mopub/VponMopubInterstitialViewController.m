//
//  VponMopubInterstitialViewController.m
//  VponMopubSampleObjC
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponMopubInterstitialViewController.h"

#import <MoPub.h>
#import "MPVponInterstitialCustomEvent.h"

@interface VponMopubInterstitialViewController () <MPInterstitialAdControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) MPInterstitialAdController *mpInterstitial;

@end

@implementation VponMopubInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mopub - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.mpInterstitial != nil && self.mpInterstitial.ready) {
        [self.mpInterstitial showFromViewController:self];
    } else {
        #warning set ad unit id
        self.mpInterstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"848bf4d03e7b4fdda02be232f8e6b4d1"];
        self.mpInterstitial.delegate = self;
        self.mpInterstitial.localExtras = @{
            @"contentURL": @"https://www.vpon.com",
            @"contentData": @{@"key1": @"MoPub", @"key2": @(1.2), @"key3": @(YES)}
        };
        [self.mpInterstitial loadAd];
    }
}

#pragma mark - MPInterstitialAdController Delegate

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    NSLog(@"Received interstitial ad successfully");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial {
    NSLog(@"Failed to receive interstitail");
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {
    NSLog(@"Interstitial did present screen");
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    NSLog(@"Interstitial did dismiss screen");
}

@end

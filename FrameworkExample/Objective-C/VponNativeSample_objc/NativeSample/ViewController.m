//
//  ViewController.m
//  NativeSample
//
//  Created by Mike Chou on 10/24/16.
//  Copyright © 2016 Vpon. All rights reserved.
//

@import VpadnSDKAdKit;
#import "ViewController.h"

@interface ViewController ()<VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAd *nativeAd;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet UIImageView *adCoverMedia;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UIButton *adAction;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.versionLabel.text = [NSString stringWithFormat:@"version: %@", [VpadnBanner getVersionVpadn]];
}

- (IBAction)loadNativeAd:(id)sender {
    if(self.nativeAd) {
        [self removePreviousAd];
    }
    self.nativeAd = [[VpadnNativeAd alloc] initWithBannerID:@"key in your native ad id"];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAdWithTestIdentifiers:@[@"key in your device's idfa"]];
//    [self.nativeAd loadAd];
}

- (void)removePreviousAd {
    [self.nativeAd unregisterView];
    self.nativeAd.delegate = nil;
    self.adIcon.image = nil;
    self.adCoverMedia.image = nil;
    self.adView.hidden = YES;
}

#pragma mark VpadnNativeAdDelegate
- (void)onVpadnNativeAdReceived:(VpadnNativeAd *)nativeAd {
    NSLog(@"VpadnNativeAd onVpadnNativeAdReceived");
    
    [self.statusLabel setHidden:YES];
    
    // icon
    __block typeof(self) safeSelf = self;
    [nativeAd.icon loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
        safeSelf.adIcon.image = image;
    }];
    // media cover
    [nativeAd.coverImage loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
        safeSelf.adCoverMedia.image = image;
    }];
    // text
    self.adTitle.text = nativeAd.title;
    self.adBody.text = nativeAd.body;
    [self.adAction setHidden:NO];
    [self.adAction setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    self.adSocialContext.text = nativeAd.socialContext;
    
//    [self.nativeAd registerViewForInteraction:self.adView withViewController:self];
//    [self.nativeAd registerViewForInteraction:self.adView withViewController:self withClickableViews:@[self.adAction]];
    [self.adView setHidden:NO];
}

- (void)onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"VpadnNativeAd didFailToReceiveAdWithError: %@", error);
    [self.statusLabel setHidden:NO];
    [self.statusLabel setText:[NSString stringWithFormat:@"Request failed with error: %d %@", (int)error.code, error.domain]];
}

- (void)onVpadnNativeAdPresent:(VpadnNativeAd *)nativeAd {
    NSLog(@"VpadnNativeAd onVpadnNativeAdPresent");
}

- (void)onVpadnNativeAdDismiss:(VpadnNativeAd *)nativeAd {
    NSLog(@"VpadnNativeAd onVpadnNativeAdDismiss");
}

- (void)onVpadnNativeAdLeaveApplication:(VpadnNativeAd *)nativeAd {
    NSLog(@"NativeAdViewController onVpadnNativeAdLeaveApplication");
}

@end

//
//  VponSdkBannerViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/7/18.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkBannerViewController.h"

@import VpadnSDKAdKit;

@interface VponSdkBannerViewController () <VpadnBannerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@end

@implementation VponSdkBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - Banner";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if (self.vpadnBanner != nil) {
        [self.vpadnBanner.getVpadnAdView removeFromSuperview];
    }
    
    _vpadnBanner = [[VpadnBanner alloc] initWithAdSize:VpadnAdSizeFromCGSize(self.loadBannerView.frame.size) origin:CGPointZero];
#warning set ad banner id
    _vpadnBanner.strBannerId = @"";
    _vpadnBanner.delegate = self;
    _vpadnBanner.platform = @"TW";
    [_vpadnBanner setAdAutoRefresh:YES];
    [_vpadnBanner setLocationOnOff:YES];
    [_vpadnBanner setRootViewController:self];
    [_vpadnBanner startGetAd:@[]];
}

#pragma mark - Vpadn Banner Delegate

- (void)onVpadnGetAd:(UIView *)bannerView {
    
}

- (void)onVpadnAdReceived:(UIView *)bannerView {
    NSLog(@"Received banner ad successfully");
    [self.loadBannerView addSubview:bannerView];
    self.requestButton.enabled = YES;
}

- (void)onVpadnAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Failed to receive banner with error: %@", [error localizedFailureReason]);
    self.requestButton.enabled = YES;
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

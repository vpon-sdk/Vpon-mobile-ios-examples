//
//  SOMAVpadnMediationPlugin.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/11.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "SOMAVpadnMediationPlugin.h"

@import VpadnSDKAdKit;

@interface SOMAVpadnMediationPlugin () <VpadnBannerDelegate, VpadnInterstitialDelegate>

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@property (strong, nonatomic) VpadnInterstitial *vpadnInterstitial;

@end


@implementation SOMAVpadnMediationPlugin

- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration *)network{
    self = [super initWithConfiguration:network];
    if (self) {
        
    }
    return self;
}

- (void) loadBanner {
    _vpadnBanner = [[VpadnBanner alloc] initWithAdSize:VpadnAdSizeSmartBannerPortrait origin:CGPointZero];
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    _vpadnBanner.strBannerId = customData[@"BANNER_ID"];
    _vpadnBanner.delegate = self;
    _vpadnBanner.platform = @"TW";
    [_vpadnBanner setAdAutoRefresh:YES];
    [_vpadnBanner setLocationOnOff:YES];
    [_vpadnBanner setRootViewController:[super rootViewController]];
    [_vpadnBanner startGetAd:@[]];
}

- (void)loadInterstitial{
    _vpadnInterstitial = [[VpadnInterstitial alloc] init];
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    _vpadnInterstitial.strBannerId = customData[@"BANNER_ID"];
    _vpadnInterstitial.platform = @"TW";
    _vpadnInterstitial.delegate = self;
    [_vpadnInterstitial setLocationOnOff:YES];
    [_vpadnInterstitial getInterstitial:@[]];
}

- (void)presentInterstitial{
    [_vpadnInterstitial show];
}

- (NSDictionary *) parseCustomData:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        return nil;
    } else {
        return data;
    }
}

#pragma mark - Vpadn Banner Delegate

- (void)onVpadnAdReceived:(UIView *)bannerView {
    [self adLoadedWithView:bannerView];
}

- (void)onVpadnAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    [self adLoadFailedWithError:error];
}

- (void)onVpadnPresent:(UIView *)bannerView {
    [self adWillPresentFullscreen];
}

- (void)onVpadnDismiss:(UIView *)bannerView {
    [self adDidDismissFullscreen];
}

- (void)onVpadnLeaveApplication:(UIView *)bannerView {
    [self adWillLeaveApplication];
}

#pragma mark - Vpadn Interstitial Delegate

- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView {
    [self adLoadedWithView:nil];
}

- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView {
    [self adLoadFailedWithError:nil];
}

- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView {
    [self adDidDismissFullscreen];
}

- (void)onVpadnInterstitialAdClicked {
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
}

@end

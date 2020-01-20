//
//  MPGoogleAdMobInterstitialCustomEvent.m
//  MoPub
//
//  Copyright (c) 2012 MoPub, Inc. All rights reserved.
//

@import VpadnSDKAdKit;

#import "MPVponInterstitialCustomEvent.h"
#import "MPInterstitialAdController.h"
#import "MPLogging.h"
#import "MPAdConfiguration.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"strBannerId"

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponInterstitialCustomEvent () <VpadnInterstitialDelegate>

@property (nonatomic, strong) VpadnInterstitial *interstitial;

@end

@implementation MPVponInterstitialCustomEvent

@synthesize interstitial = _interstitial;

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    MPLogInfo(@"Requesting Vpon interstitial");
    if (_interstitial) {
        _interstitial.delegate = nil;
        _interstitial = nil;
    }
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    // 請新增此function到您的程式內 如果為測試用 則在下方填入IDFA
    [request setTestDevices:@[]];
    
    _interstitial = [[VpadnInterstitial alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    _interstitial.delegate = self;
    [_interstitial loadRequest:request];
}

- (void) requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    [self requestInterstitialWithCustomEventInfo:info adMarkup:nil];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    if (_interstitial) {
        [self.delegate interstitialCustomEventWillAppear:self];
        [_interstitial showFromRootViewController:rootViewController];
        [self.delegate interstitialCustomEventDidAppear:self];
    }
}

#pragma mark VpadnInterstitial Delegate 有接Interstitial的廣告才需要新增

- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView{
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
        [self.delegate interstitialCustomEvent:self didLoadAd:self];
    }
}

- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView {
    NSError *error = [NSError errorWithDomain:@"com.vpon.vpadnsdk" code:-999 userInfo:@{NSLocalizedDescriptionKey:@"get VpadnInterstitialAdFailed"}];
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView{
    MPLogAdEvent([MPLogEvent adDidDisappearForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
//    [UIApplication sharedApplication]
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

@end

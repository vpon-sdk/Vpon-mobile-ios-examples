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

#define VP_CONTENT_URL @"contentURL"
#define VP_CONTENT_DATA @"contentData"

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
    
    _interstitial = [[VpadnInterstitial alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    _interstitial.delegate = self;
    [_interstitial loadRequest:[self createRequest]];
}

- (void) requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    [self requestInterstitialWithCustomEventInfo:info adMarkup:nil];
}

- (VpadnAdRequest *) createRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    [request setAutoRefresh:NO];
    if ([request respondsToSelector:@selector(setContentData:)] &&
        [self.localExtras.allKeys containsObject:VP_CONTENT_DATA] &&
        [self.localExtras[VP_CONTENT_DATA] isKindOfClass:[NSDictionary class]]) {
        [request setContentData:self.localExtras[VP_CONTENT_DATA]];
    }
    if ([request respondsToSelector:@selector(setContentUrl:)] &&
        [self.localExtras.allKeys containsObject:VP_CONTENT_URL] &&
        [self.localExtras[VP_CONTENT_URL] isKindOfClass:[NSString class]]) {
        [request setContentUrl:self.localExtras[VP_CONTENT_URL]];
    }
    // 請新增此function到您的程式內 如果為測試用 則在下方填入IDFA
    [request setTestDevices:@[]];
    return request;
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    if (_interstitial) {
        [self.delegate interstitialCustomEventWillAppear:self];
        [_interstitial showFromRootViewController:rootViewController];
        [self.delegate interstitialCustomEventDidAppear:self];
    }
}

#pragma mark VpadnInterstitial Delegate 有接Interstitial的廣告才需要新增

- (void) onVpadnInterstitialLoaded:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
        [self.delegate interstitialCustomEvent:self didLoadAd:self];
    }
}

- (void) onVpadnInterstitial:(VpadnInterstitial *)interstitial failedToLoad:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void) onVpadnInterstitialWillOpen:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adWillPresentModalForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventWillAppear:)]) {
        [self.delegate interstitialCustomEventWillAppear:self];
    }
}

- (void) onVpadnInterstitialClosed:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adDidDismissModalForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
}

- (void) onVpadnInterstitialWillLeaveApplication:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adWillLeaveApplicationForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventWillLeaveApplication:)]) {
        [self.delegate interstitialCustomEventWillLeaveApplication:self];
    }
}

@end

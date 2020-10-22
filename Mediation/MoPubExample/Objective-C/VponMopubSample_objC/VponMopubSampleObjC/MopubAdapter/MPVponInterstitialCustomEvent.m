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

#define VP_CONTENT_FRIENDLY_OBS @"friendlyObstructions"
#define VP_CONTENT_FRIENDLY_VIEW @"view"
#define VP_CONTENT_FRIENDLY_PURPOSE @"purpose"
#define VP_CONTENT_FRIENDLY_DESC @"desc"

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponInterstitialCustomEvent () <VpadnInterstitialDelegate>

@property (nonatomic, strong) VpadnInterstitial *interstitial;

@end

@implementation MPVponInterstitialCustomEvent

@synthesize interstitial = _interstitial;

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestAdWithAdapterInfo:(NSDictionary *)info adMarkup:(NSString * _Nullable)adMarkup {
    MPLogInfo(@"Requesting Vpon interstitial");
    if (_interstitial) {
        _interstitial.delegate = nil;
        _interstitial = nil;
    }
    
    _interstitial = [[VpadnInterstitial alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    _interstitial.delegate = self;
    [_interstitial loadRequest:[self createRequest]];
}

- (void)presentAdFromViewController:(UIViewController *)viewController {
    if (_interstitial) {
        [_interstitial showFromRootViewController:viewController];
        [self.delegate fullscreenAdAdapterAdDidAppear:self];
    }
}

- (void)handleDidPlayAd {
    
}

- (void)handleDidInvalidateAd {
    
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
    if ([request respondsToSelector:@selector(addFriendlyObstruction:purpose:description:)] &&
        [self.localExtras.allKeys containsObject:VP_CONTENT_FRIENDLY_OBS] &&
        [self.localExtras[VP_CONTENT_FRIENDLY_OBS] isKindOfClass:[NSArray class]]) {
        NSArray *friendlyObstructions = self.localExtras[VP_CONTENT_FRIENDLY_OBS];
        for (NSDictionary *friendlyObstruction in friendlyObstructions) {
            if (![friendlyObstruction isKindOfClass:NSDictionary.class]) continue;
            if (![friendlyObstruction[VP_CONTENT_FRIENDLY_VIEW] isKindOfClass:UIView.class]) continue;
            UIView *view = friendlyObstruction[VP_CONTENT_FRIENDLY_VIEW];
            NSString *desc = [friendlyObstruction[VP_CONTENT_FRIENDLY_DESC] isKindOfClass:NSString.class] ? friendlyObstruction[VP_CONTENT_FRIENDLY_DESC] : @"";
            VpadnFriendlyObstructionType purpose = VpadnFriendlyObstructionOther;
            if ([friendlyObstruction.allKeys containsObject:VP_CONTENT_FRIENDLY_PURPOSE]) {
                purpose = [VpadnAdObstruction getVpadnPurpose:[friendlyObstruction[VP_CONTENT_FRIENDLY_PURPOSE] integerValue]];
            }
            [request addFriendlyObstruction:view purpose:purpose description:desc];
        }
    }
    // 請新增此function到您的程式內 如果為測試用 則在下方填入IDFA
    [request setTestDevices:@[]];
    return request;
}

#pragma mark VpadnInterstitial Delegate 有接Interstitial的廣告才需要新增

- (void) onVpadnInterstitialLoaded:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(fullscreenAdAdapterDidLoadAd:)]) {
        [self.delegate fullscreenAdAdapterDidLoadAd:self];
    }
}

- (void) onVpadnInterstitial:(VpadnInterstitial *)interstitial failedToLoad:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(fullscreenAdAdapter:didFailToLoadAdWithError:)]) {
        [self.delegate fullscreenAdAdapter:self didFailToLoadAdWithError:error];
    }
}

- (void) onVpadnInterstitialWillOpen:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adWillPresentModalForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(fullscreenAdAdapterAdWillAppear:)]) {
        [self.delegate fullscreenAdAdapterAdWillAppear:self];
    }
}

- (void) onVpadnInterstitialClosed:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adDidDismissModalForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(fullscreenAdAdapterAdDidDisappear:)]) {
        [self.delegate fullscreenAdAdapterAdDidDisappear:self];
    }
}

- (void) onVpadnInterstitialWillLeaveApplication:(VpadnInterstitial *)interstitial {
    MPLogAdEvent([MPLogEvent adWillLeaveApplicationForAdapter:NSStringFromClass(self.class)], nil);
    if(self.delegate && [self.delegate respondsToSelector:@selector(fullscreenAdAdapterWillLeaveApplication:)]) {
        [self.delegate fullscreenAdAdapterWillLeaveApplication:self];
    }
}

@end

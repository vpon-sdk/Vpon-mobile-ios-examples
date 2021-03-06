//
//  MPBannerCustomEvent.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

@import VpadnSDKAdKit;

#import "MPVponBannerCustomEvent.h"
#import "MPLogging.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"strBannerId"

#define VP_CONTENT_URL @"contentURL"
#define VP_CONTENT_DATA @"contentData"

#define VP_CONTENT_FRIENDLY_OBS @"friendlyObstructions"
#define VP_CONTENT_FRIENDLY_VIEW @"view"
#define VP_CONTENT_FRIENDLY_PURPOSE @"purpose"
#define VP_CONTENT_FRIENDLY_DESC @"desc"

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponBannerCustomEvent () <VpadnBannerDelegate>

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@end


@implementation MPVponBannerCustomEvent

- (void) requestAdWithSize:(CGSize)size adapterInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    MPLogInfo(@"Requesting Vpon banner");
    VpadnAdSize adSize = VpadnAdSizeSmartBannerPortrait;
    if (CGSizeEqualToSize(size, VpadnAdSizeMediumRectangle.size) || (size.height >= 250.0 && size.width / size.height <= 300 / 250.0 )) {
        adSize = VpadnAdSizeMediumRectangle;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeFullBanner.size)) {
        adSize = VpadnAdSizeFullBanner;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeLeaderboard.size)) {
        adSize = VpadnAdSizeLeaderboard;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeLargeRectangle.size)) {
        adSize = VpadnAdSizeLargeRectangle;
    } else {
        adSize = VpadnAdSizeFromCGSize(size);
    }
    _vpadnBanner = [[VpadnBanner alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID] adSize:adSize];
    _vpadnBanner.delegate = self;
    [_vpadnBanner loadRequest:[self createRequest]];
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

#pragma mark -
#pragma mark VpadnAdDelegate method 接一般Banner廣告就需要新增

- (void) onVpadnAdLoaded:(VpadnBanner *)banner {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(inlineAdAdapter:didLoadAdWithAdView:)]) {
        [self.delegate inlineAdAdapter:self didLoadAdWithAdView:banner.getVpadnAdView];
    }
}

- (void) onVpadnAd:(VpadnBanner *)banner failedToLoad:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(inlineAdAdapter:didFailToLoadAdWithError:)]) {
        [self.delegate inlineAdAdapter:self didFailToLoadAdWithError:error];
    }
}

- (void) onVpadnAdDidImpression:(VpadnBanner *)banner {
    [self.delegate inlineAdAdapterDidTrackImpression:self];
}

- (void) onVpadnAdClicked:(VpadnBanner *)banner {
    [self.delegate inlineAdAdapterDidTrackClick:self];
}

- (void) onVpadnAdWillOpen:(VpadnBanner *)banner {
    MPLogAdEvent([MPLogEvent adWillPresentModalForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(inlineAdAdapterWillBeginUserAction:)]) {
        [self.delegate inlineAdAdapterWillBeginUserAction:self];
    }
}

- (BOOL) enableAutomaticImpressionAndClickTracking {
    return NO;
}

- (void) onVpadnAdClosed:(VpadnBanner *)banner {
    MPLogAdEvent([MPLogEvent adDidDismissModalForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(inlineAdAdapterDidEndUserAction:)]) {
        [self.delegate inlineAdAdapterDidEndUserAction:self];
    }
}

- (void) onVpadnAdWillLeaveApplication:(VpadnBanner *)banner {
    MPLogAdEvent([MPLogEvent adWillLeaveApplicationForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(inlineAdAdapterWillLeaveApplication:)]) {
        [self.delegate inlineAdAdapterWillLeaveApplication:self];
    }
}

@end

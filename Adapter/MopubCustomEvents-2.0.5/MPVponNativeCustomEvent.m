//
//  MPVponNativeCustomEvent.m
//  Vpon
//
//  Copyright (c) 2016 Vpon. All rights reserved.
//

@import VpadnSDKAdKit;

#import "MPVponNativeCustomEvent.h"
#import "MPVponNativeAdAdapter.h"
#import "MPNativeAd.h"
#import "MPNativeAdError.h"
#import "MPLogging.h"
#import "MPNativeAdConstants.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"strBannerId"

#define VP_CONTENT_URL @"contentURL"
#define VP_CONTENT_DATA @"contentData"

#define VP_CONTENT_FRIENDLY_OBS @"friendlyObstructions"
#define VP_CONTENT_FRIENDLY_VIEW @"view"
#define VP_CONTENT_FRIENDLY_PURPOSE @"purpose"
#define VP_CONTENT_FRIENDLY_DESC @"desc"

static const NSInteger VpadnNoFillErrorCode = -25;

@interface MPVponNativeCustomEvent () <VpadnNativeAdDelegate>

@property (nonatomic, readwrite, strong) VpadnNativeAd *vpadnNativeAd;

@end

@implementation MPVponNativeCustomEvent

- (void) requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    MPLogInfo(@"Requesting Vpon native");
    _vpadnNativeAd = [[VpadnNativeAd alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    _vpadnNativeAd.delegate = self;
    [_vpadnNativeAd loadRequest:[self createRequest]];
}

- (VpadnAdRequest *) createRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
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

- (void) requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self requestAdWithCustomEventInfo:info adMarkup:nil];
}

#pragma mark - VpadnNativeAdDelegate

- (void) onVpadnNativeAdLoaded:(VpadnNativeAd *)nativeAd {
    MPVponNativeAdAdapter  *adAdapter = [[MPVponNativeAdAdapter alloc] initWithNativeAd:nativeAd];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    if (nativeAd.icon.url) {
        [imageURLs addObject:nativeAd.icon.url];
    }
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForImageDownloadFailure()];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd failedToLoad:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
        if (error.code == VpadnNoFillErrorCode) {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForNoInventory()];
        } else {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForInvalidAdServerResponse([NSString stringWithFormat:@"Vpadn ad load error: %li", (long)error.code])];
        }
    }
}

@end

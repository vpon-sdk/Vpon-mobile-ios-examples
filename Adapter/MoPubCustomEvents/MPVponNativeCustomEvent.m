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

static const NSInteger VpadnNoFillErrorCode = -25;

@interface MPVponNativeCustomEvent () <VpadnNativeAdDelegate>

@property (nonatomic, readwrite, strong) VpadnNativeAd *vpadnNativeAd;

@end

@implementation MPVponNativeCustomEvent

- (void) requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    MPLogInfo(@"Requesting Vpon native");
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    // 請新增此function到您的程式內 如果為測試用 則在下方填入IDFA
    [request setTestDevices:@[]];
    
    _vpadnNativeAd = [[VpadnNativeAd alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    _vpadnNativeAd.delegate = self;
    [_vpadnNativeAd loadRequest:request];
}

- (void) requestAdWithCustomEventInfo:(NSDictionary *)info {
    [self requestAdWithCustomEventInfo:info adMarkup:nil];
}

#pragma mark - VpadnNativeAdDelegate

/**
 通知拉取廣告成功pre-fetch完成 call back
 */
- (void)onVpadnNativeAdReceived:(VpadnNativeAd *)nativeAd {
    MPVponNativeAdAdapter  *adAdapter = [[MPVponNativeAdAdapter alloc] initWithNativeAd:nativeAd];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    if (nativeAd.icon.url) {
        [imageURLs addObject:nativeAd.icon.url];
    }
    
    if (nativeAd.coverImage.url) {
        [imageURLs addObject:nativeAd.coverImage.url];
    }
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForImageDownloadFailure()];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

/**
 通知拉取廣告失敗 call back
 */
- (void)onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]) {
        if (error.code == VpadnNoFillErrorCode) {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForNoInventory()];
        } else {
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForInvalidAdServerResponse([NSString stringWithFormat:@"Vpadn ad load error: %li", error.code])];
        }
    }
}

@end

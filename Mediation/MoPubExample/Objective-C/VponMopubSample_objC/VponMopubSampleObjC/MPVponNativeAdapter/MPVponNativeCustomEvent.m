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

static const NSInteger VpadnNoFillErrorCode = -25;

@interface MPVponNativeCustomEvent () <VpadnNativeAdDelegate>

@property (nonatomic, readwrite, strong) VpadnNativeAd *vpadnNativeAd;

@end

@implementation MPVponNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info
{
    NSString *strBannerId = [info objectForKey:@"strBannerId"];  //the placement set in the MoPub platform

    if (strBannerId) {
        _vpadnNativeAd = [[VpadnNativeAd alloc] initWithBannerID:strBannerId];
        self.vpadnNativeAd.delegate = self;
        
        [self.vpadnNativeAd loadAdWithTestIdentifiers:@[@"please insert testing device's idfa"]];
    } else {
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForInvalidAdServerResponse(@"Invalid Vpadn Banner ID")];
    }
}

#pragma mark - VpadnNativeAdDelegate
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
            MPLogDebug(@"%@", errors);
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForImageDownloadFailure()];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void)onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error {
    
    if (error.code == VpadnNoFillErrorCode) {
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForNoInventory()];
    } else {
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForInvalidAdServerResponse([NSString stringWithFormat:@"Vpadn ad load error: %li", error.code])];
    }
}

@end

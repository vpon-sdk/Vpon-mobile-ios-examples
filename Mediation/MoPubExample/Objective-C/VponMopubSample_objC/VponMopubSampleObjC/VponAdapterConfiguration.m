//
//  VponAdapterConfiguration.m
//  VponMopubSampleObjC
//
//  Created by EricChien on 2019/2/20.
//  Copyright © 2019 Soul. All rights reserved.
//

#import "VponAdapterConfiguration.h"
#import <VpadnSDKAdKit/VpadnSDKAdKit.h>

#if __has_include("MoPub.h")
#import "MPLogging.h"
#endif

@implementation VponAdapterConfiguration

#pragma mark - MPAdapterConfiguration

- (NSString *)adapterVersion {
    return @"1.0.0";
}

- (NSString *)biddingToken {
    return nil;
}

- (NSString *)moPubNetworkName {
    return @"Vpon";
}

- (NSString *)networkSdkVersion {
    return [VpadnBanner getVersionVpadn];
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration
                                  complete:(void(^)(NSError *))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        VpadnBanner *banner = [[VpadnBanner alloc] initWithAdSize:VpadnAdSizeSmartBannerPortrait];
        VpadnInterstitial *interstitial = [[VpadnInterstitial alloc] init];
        VpadnNativeAd *vpadnNativeAd = [[VpadnNativeAd alloc] initWithBannerID:@""];
        if (banner && interstitial && vpadnNativeAd) {
            MPLogDebug(@"Initialized Vpadn");
        }
    });
    
    if (complete != nil) {
        complete(nil);
    }
}

@end

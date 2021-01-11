//
//  MPVponAdapterConfigutation.m
//  VponSdkSampleObjC
//
//  Created by Yi-Hsiang, Chien on 2020/12/16.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "MPVponAdapterConfigutation.h"
#import <VpadnSDKAdKit/VpadnSDKAdKit.h>

#if __has_include("MoPub.h")
#import "MPLogging.h"
#endif

static BOOL gInitialized = NO;

@implementation MPVponAdapterConfigutation

+ (BOOL)isSdkInitialized {
    return gInitialized;
}

+ (void)setIsSdkInitialized:(BOOL)isSdkInitialized {
    gInitialized = isSdkInitialized;
}

+ (void) setCachedInitializationParameters:(NSDictionary<NSString *,id> *)parameters {
    
}

- (NSString *) adapterVersion {
    return @"2.0.5";
}

- (NSString *) biddingToken {
    return nil;
}

- (NSString *) moPubNetworkName {
    return @"vpon";
}

- (NSString *) networkSdkVersion {
    return [VpadnAdRequest sdkVersion];
}

- (void) initializeNetworkWithConfiguration:(NSDictionary<NSString *,id> *)configuration complete:(void (^)(NSError * _Nullable))complete {
    MPVponAdapterConfigutation.isSdkInitialized = (configuration != nil);
    complete(nil);
}

@end


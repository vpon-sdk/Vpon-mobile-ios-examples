//
//  MPVponNativeAdAdapter.h
//  Vpon
//
//  Copyright (c) 2016 Vpon. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#else
    #import "MPNativeAdAdapter.h"
#endif

@class VpadnNativeAd;

@interface MPVponNativeAdAdapter : NSObject <MPNativeAdAdapter>

@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;

- (instancetype)initWithNativeAd:(VpadnNativeAd *)nativeAd;

@end

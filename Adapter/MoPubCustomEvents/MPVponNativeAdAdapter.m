//
//  MPVponNativeAdAdapter.m
//  Vpon
//
//  Copyright (c) 2016 MoPub. All rights reserved.
//

@import VpadnSDKAdKit;
#import "MPVponNativeAdAdapter.h"
#import "MPNativeAdConstants.h"
#import "MPNativeAdError.h"
#import "MPLogging.h"


@interface MPVponNativeAdAdapter () <VpadnNativeAdDelegate>

@property (nonatomic, readonly) VpadnNativeAd *vpadnNativeAd;

@end

@implementation MPVponNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithNativeAd:(VpadnNativeAd *)nativeAd {
    if (self = [super init]) {
        _vpadnNativeAd = nativeAd;
        _vpadnNativeAd.delegate = self;

        NSNumber *starRating = nil;

        // Normalize star rating to 5 stars.
        if (_vpadnNativeAd.ratingScale!= 0) {
            CGFloat ratio = 0.0f;
            
            ratio = kUniversalStarRatingScale / nativeAd.ratingScale;
            starRating = [NSNumber numberWithFloat:ratio * nativeAd.ratingValue];
        }

        NSMutableDictionary *properties = [NSMutableDictionary dictionary];
        
        if (starRating) {
            [properties setObject:starRating forKey:kAdStarRatingKey];
        }

        if (nativeAd.title) {
            [properties setObject:nativeAd.title forKey:kAdTitleKey];
        }

        if (nativeAd.body) {
            [properties setObject:nativeAd.body forKey:kAdTextKey];
        }

        if (nativeAd.callToAction) {
            [properties setObject:nativeAd.callToAction forKey:kAdCTATextKey];
        }

        if (nativeAd.icon.url.absoluteString) {
            [properties setObject:nativeAd.icon.url.absoluteString forKey:kAdIconImageKey];
        }

        if (nativeAd.strBannerId) {
            [properties setObject:nativeAd.strBannerId forKey:@"strBannerId"];
        }

        if (nativeAd.socialContext) {
            [properties setObject:nativeAd.socialContext forKey:@"socialContext"];
        }

        if (nativeAd.coverImage.url.absoluteString) {
            [properties setObject:nativeAd.coverImage.url.absoluteString forKey:kAdMainImageKey];
        }
        
        _properties = properties;
    }

    return self;
}


#pragma mark - MPNativeAdAdapter

- (NSURL *)defaultActionURL
{
    return nil;
}

- (BOOL)enableThirdPartyClickTracking {
    return YES;
}

- (void)willAttachToView:(UIView *)view withAdContentViews:(NSArray *)adContentViews {
    [self.vpadnNativeAd registerViewForInteraction:view withViewController:[self.delegate viewControllerForPresentingModalView] withClickableViews:adContentViews];
}

- (void)willAttachToView:(UIView *)view
{
    [self.vpadnNativeAd registerViewForInteraction:view withViewController:[self.delegate viewControllerForPresentingModalView]];
}

#pragma mark - VpadnNativeAdDelegate

- (void) onVpadnNativeAdWillLeaveApplication:(VpadnNativeAd *)nativeAd {
    [self.delegate nativeAdWillLeaveApplicationFromAdapter:self];
}

- (void) onVpadnNativeAdClicked:(VpadnNativeAd *)nativeAd {
    [self.delegate nativeAdDidClick:self];
}

@end

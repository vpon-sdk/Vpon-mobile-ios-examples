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


@interface MPVponNativeAdAdapter () <VpadnNativeAdDelegate, VpadnMediaViewDelegate>

@property (nonatomic, readonly) VpadnNativeAd *vpadnNativeAd;

@property (nonatomic, strong) VpadnMediaView *vpadnMediaView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UIView *adContainer;

@property (nonatomic, weak) NSArray *adContentViews;


@end

@implementation MPVponNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithNativeAd:(VpadnNativeAd *)nativeAd {
    if (self = [super init]) {
        _vpadnNativeAd = nativeAd;
        _vpadnNativeAd.delegate = self;
        
        _vpadnMediaView = [[VpadnMediaView alloc] initWithNativeAd:_vpadnNativeAd];
        _vpadnMediaView.delegate = self;

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
        
        if (_vpadnMediaView) {
            [properties setObject:_vpadnMediaView forKey:kAdMainMediaViewKey];
        }
        
        _properties = properties;
    }

    return self;
}


#pragma mark - MPNativeAdAdapter

- (UIView *) mainMediaView {
    return _vpadnMediaView;
}

- (NSURL *) defaultActionURL
{
    return nil;
}

- (BOOL) enableThirdPartyClickTracking {
    return YES;
}

- (void) registerViewForInteraction {
    if (_adContainer.superview) {
        [self cancelRegisterTimer];
        if (_adContentViews) {
            [self.vpadnNativeAd registerViewForInteraction:_adContainer withViewController:[self.delegate viewControllerForPresentingModalView] withClickableViews:_adContentViews];
        } else {
            [self.vpadnNativeAd registerViewForInteraction:_adContainer withViewController:[self.delegate viewControllerForPresentingModalView]];
        }
    } else {
        [self startRegisterTimer];
    }
}

- (void) cancelRegisterTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) startRegisterTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(registerViewForInteraction) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)willAttachToView:(UIView *)view withAdContentViews:(NSArray *)adContentViews {
    _adContainer = view;
    _adContentViews = adContentViews;
    [self startRegisterTimer];
}

- (void)willAttachToView:(UIView *)view {
    _adContainer = view;
    [self startRegisterTimer];
}

#pragma mark - VpadnNativeAdDelegate

- (void) onVpadnNativeAdWillLeaveApplication:(VpadnNativeAd *)nativeAd {
    [self.delegate nativeAdWillLeaveApplicationFromAdapter:self];
}

- (void) onVpadnNativeAdClicked:(VpadnNativeAd *)nativeAd {
    [self.delegate nativeAdDidClick:self];
}

- (void) onVpadnNativeAdDidImpression:(VpadnNativeAd *)nativeAd {
    [self.delegate nativeAdWillLogImpression:self];
}

#pragma mark - VpadnMediaView Delegate

- (void) mediaViewDidLoad:(VpadnMediaView *)mediaView{
    MPLogInfo(@"Vpon media view is ready.");
}

- (void) mediaViewDidFailed:(VpadnMediaView *)mediaView error:(NSError *)error {
    
}

@end

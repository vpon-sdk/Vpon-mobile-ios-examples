//
//  MPGoogleAdMobBannerCustomEvent.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

@import VpadnSDKAdKit;

#import "MPVponBannerCustomEvent.h"
#import "MPLogging.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"strBannerId"

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponBannerCustomEvent () <VpadnBannerDelegate>

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@end


@implementation MPVponBannerCustomEvent

- (void) requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    MPLogInfo(@"Requesting Vpon banner");
    
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    // 請新增此function到您的程式內 如果為測試用 則在下方填入IDFA
    [request setTestDevices:@[]];
    
    
    VpadnAdSize adSize = VpadnAdSizeSmartBannerPortrait;
    if (CGSizeEqualToSize(size, VpadnAdSizeMediumRectangle.size) || (size.height == 250.0 && size.width >= 300)) {
        adSize = VpadnAdSizeMediumRectangle;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeFullBanner.size)) {
        adSize = VpadnAdSizeFullBanner;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeLeaderboard.size)) {
        adSize = VpadnAdSizeLeaderboard;
    } else {
        adSize = VpadnAdSizeBanner;
    }
    
    _vpadnBanner = [[VpadnBanner alloc] initWithLicenseKey:[info objectForKey:EXTRA_INFO_BANNER_ID] adSize:adSize];
    _vpadnBanner.delegate = self;
    [_vpadnBanner loadRequest:request];
}

- (void) requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    [self requestAdWithSize:size customEventInfo:info adMarkup:nil];
}

#pragma mark -
#pragma mark VpadnAdDelegate method 接一般Banner廣告就需要新增

/// 通知拉取廣告成功pre-fetch完成 call back
- (void) onVpadnAdReceived:(UIView *)bannerView {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEvent:didLoadAd:)]) {
        [self.delegate bannerCustomEvent:self didLoadAd:bannerView];
    }
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
    }
}

/// 通知開啟vpadn廣告頁面 call back
- (void) onVpadnPresent:(UIView *)bannerView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEventWillBeginAction:)]) {
        [self.delegate bannerCustomEventWillBeginAction:self];
    }
}

/// 通知關閉vpadn廣告頁面 call back
- (void) onVpadnDismiss:(UIView *)bannerView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEventDidFinishAction:)]) {
        [self.delegate bannerCustomEventDidFinishAction:self];
    }
}

/// 通知離開publisher應用程式 call back
- (void) onVpadnLeaveApplication:(UIView *)bannerView {
    MPLogAdEvent([MPLogEvent adWillLeaveApplicationForAdapter:NSStringFromClass(self.class)], nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEventWillLeaveApplication:)]) {
        [self.delegate bannerCustomEventWillLeaveApplication:self];
    }
}

@end

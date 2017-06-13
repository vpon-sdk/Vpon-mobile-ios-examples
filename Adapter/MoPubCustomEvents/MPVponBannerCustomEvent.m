//
//  MPGoogleAdMobBannerCustomEvent.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "VpadnBanner.h"
#import "MPVponBannerCustomEvent.h"
#import "MPLogging.h"
#import "MPInstanceProvider.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"bannerid"

@interface MPInstanceProvider (VponBanners)
- (VpadnBanner *)buildVpadnBannerViewWithFrame:(VpadnAdSize)adSize;
@end

@implementation MPInstanceProvider (AdMobBanners)

- (VpadnBanner *)buildVpadnBannerViewWithFrame:(VpadnAdSize)adSize
{
    return [[VpadnBanner alloc] initWithAdSize:adSize];
}
@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponBannerCustomEvent () <VpadnBannerDelegate>

@property (nonatomic, strong) VpadnBanner *adBannerView;

@end


@implementation MPVponBannerCustomEvent

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [self.adBannerView destroyBanner];
    self.adBannerView = nil;
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting Vpon banner");
    VpadnAdSize adSize = VpadnAdSizeSmartBannerPortrait;
    if (CGSizeEqualToSize(size, VpadnAdSizeMediumRectangle.size)) {
        adSize = VpadnAdSizeMediumRectangle;
    } else if (CGSizeEqualToSize(size, VpadnAdSizeFullBanner.size)) {
        adSize = VpadnAdSizeFullBanner;
    } else if (size.width == VpadnAdSizeLeaderboard.size.width) {
        adSize = VpadnAdSizeLeaderboard;
    } else if (size.height == VpadnAdSizeBanner.size.height) {
        adSize = VpadnAdSizeBanner;
    } else {
        MPLogError(@"Invalid size for Vpon banner ad");
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
        return;
    }

    if(self.adBannerView)
    {
        [self.adBannerView destroyBanner];
        self.adBannerView = nil;
    }
    self.adBannerView               = [[MPInstanceProvider sharedProvider] buildVpadnBannerViewWithFrame:adSize];
    self.adBannerView.strBannerId   = [info objectForKey:EXTRA_INFO_BANNER_ID];
    self.adBannerView.platform      = [info objectForKey:EXTRA_INFO_ZONE];
    self.adBannerView.delegate      = self;
    self.adBannerView.rootViewController = [[UIApplication sharedApplication]keyWindow].rootViewController;
    
    [self.adBannerView startGetAd:[self getTestIdentifiers]];
}

// 請新增此function到您的程式內 如果為測試用 則在下方填入UUID
-(NSArray*)getTestIdentifiers
{
    return [NSArray arrayWithObjects:
            // add your test UUID
            nil];
}

#pragma mark -
#pragma mark VpadnAdDelegate method 接一般Banner廣告就需要新增
- (void)onVpadnAdReceived:(UIView *)bannerView{
    NSLog(@"廣告抓取成功");
    if(self.delegate)
        [self.delegate bannerCustomEvent:self didLoadAd:bannerView];
}

- (void)onVpadnAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"廣告抓取失敗");
    if(self.delegate)
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)onVpadnPresent:(UIView *)bannerView{
    NSLog(@"開啟vpadn廣告頁面 %@",bannerView);
    if(self.delegate)
        [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)onVpadnDismiss:(UIView *)bannerView{
    NSLog(@"關閉vpadn廣告頁面 %@",bannerView);
    if(self.delegate)
        [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)onVpadnLeaveApplication:(UIView *)bannerView{
    NSLog(@"離開publisher application");
    if(self.delegate)
        [self.delegate bannerCustomEventWillLeaveApplication:self];
}

@end

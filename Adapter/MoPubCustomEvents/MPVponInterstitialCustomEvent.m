//
//  MPGoogleAdMobInterstitialCustomEvent.m
//  MoPub
//
//  Copyright (c) 2012 MoPub, Inc. All rights reserved.
//

@import VpadnSDKAdKit;

#import "MPVponInterstitialCustomEvent.h"
#import "MPInterstitialAdController.h"
#import "MPLogging.h"
#import "MPAdConfiguration.h"

#define EXTRA_INFO_ZONE         @"zone"
#define EXTRA_INFO_BANNER_ID    @"strBannerId"

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MPVponInterstitialCustomEvent () <VpadnInterstitialDelegate>

@property (nonatomic, strong) VpadnInterstitial *interstitial;

@end

@implementation MPVponInterstitialCustomEvent

@synthesize interstitial = _interstitial;

#pragma mark - MPInterstitialCustomEvent Subclass Methods

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting Vpon interstitial");
    if(self.interstitial)
    {
        self.interstitial.delegate = nil;
        self.interstitial = nil;
    }
    self.interstitial = [[VpadnInterstitial alloc] init];

    [self.interstitial setStrBannerId:[info objectForKey:EXTRA_INFO_BANNER_ID]];
    self.interstitial.delegate = self;
    self.interstitial.platform = [info objectForKey:EXTRA_INFO_ZONE];
    [self.interstitial getInterstitial:[self getTestIdentifiers]];
}

// 請新增此function到您的程式內 如果為測試用 則在下方填入UUID
-(NSArray*)getTestIdentifiers
{
    return [NSArray arrayWithObjects:
            // add your test UUID
            nil];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if(self.interstitial)
    {
        [self.interstitial show];
        [self.delegate interstitialCustomEventWillAppear:self];
        [self.delegate interstitialCustomEventDidAppear:self];
    }
}

- (void)dealloc
{
    self.interstitial.delegate = nil;
    self.interstitial = nil;
}

#pragma mark VpadnInterstitial Delegate 有接Interstitial的廣告才需要新增
- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView{
    NSLog(@"插屏廣告抓取成功");
    if(self.delegate)
        [self.delegate interstitialCustomEvent:self didLoadAd:self];
}

- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView{
    NSLog(@"插屏廣告抓取失敗");
    if(self.delegate)
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}

- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView{
    NSLog(@"關閉插屏廣告頁面 %@",bannerView);
    if(self.delegate)
    {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

@end

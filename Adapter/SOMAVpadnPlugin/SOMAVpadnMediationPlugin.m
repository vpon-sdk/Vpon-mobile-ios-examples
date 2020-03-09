//
//  SOMAVpadnMediationPlugin.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/11.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "SOMAVpadnMediationPlugin.h"

@import VpadnSDKAdKit;

@interface SOMAVpadnMediationPlugin () <VpadnBannerDelegate, VpadnInterstitialDelegate>

@property (strong, nonatomic) VpadnBanner *vpadnBanner;

@property (strong, nonatomic) VpadnInterstitial *vpadnInterstitial;

@end


@implementation SOMAVpadnMediationPlugin

- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration *)network{
    self = [super initWithConfiguration:network];
    if (self) {
        
    }
    return self;
}

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    return request;
}

- (void) loadBanner {
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    
    VpadnAdSize adSize = VpadnAdSizeSmartBannerPortrait;
    if (CGSizeEqualToSize(self.somaBannerSize, VpadnAdSizeMediumRectangle.size) || (self.somaBannerSize.height == 250.0 && self.somaBannerSize.width >= 300)) {
        adSize = VpadnAdSizeMediumRectangle;
    } else if (CGSizeEqualToSize(self.somaBannerSize, VpadnAdSizeFullBanner.size)) {
        adSize = VpadnAdSizeFullBanner;
    } else if (CGSizeEqualToSize(self.somaBannerSize, VpadnAdSizeLeaderboard.size)) {
        adSize = VpadnAdSizeLeaderboard;
    } else {
        adSize = VpadnAdSizeBanner;
    }
    
    _vpadnBanner = [[VpadnBanner alloc] initWithLicenseKey:customData[@"BANNER_ID"] adSize:adSize];
    _vpadnBanner.delegate = self;
    [_vpadnBanner loadRequest:[self initialRequest]];
}

- (void)loadInterstitial{
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    _vpadnInterstitial = [[VpadnInterstitial alloc] initWithLicenseKey:customData[@"BANNER_ID"]];
    _vpadnInterstitial.delegate = self;
    [_vpadnInterstitial loadRequest:[self initialRequest]];
}

- (void)presentInterstitial {
    [_vpadnInterstitial showFromRootViewController:[self rootViewController]];
}

- (NSDictionary *) parseCustomData:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        return nil;
    } else {
        return data;
    }
}

#pragma mark - Vpadn Banner Delegate

- (void) onVpadnAdLoaded:(VpadnBanner *)banner {
    [self adLoadedWithView:[banner getVpadnAdView]];
}

- (void) onVpadnAd:(VpadnBanner *)banner failedToLoad:(NSError *)error {
    [self adLoadFailedWithError:error];
}

- (void) onVpadnAdWillOpen:(VpadnBanner *)banner {
    [self adWillPresentFullscreen];
}

- (void) onVpadnAdClosed:(VpadnBanner *)banner {
    [self adDidDismissFullscreen];
}

- (void) onVpadnAdWillLeaveApplication:(VpadnBanner *)banner {
    [self adWillLeaveApplication];
}

#pragma mark - Vpadn Interstitial Delegate

- (void) onVpadnInterstitialLoaded:(VpadnInterstitial *)interstitial {
    [self adLoadedWithView:nil];
}

- (void) onVpadnInterstitial:(VpadnInterstitial *)interstitial failedToLoad:(NSError *)error {
    [self adLoadFailedWithError:nil];
}

- (void) onVpadnInterstitialWillOpen:(VpadnInterstitial *)interstitial {
    [self adWillPresentFullscreen];
}

- (void) onVpadnInterstitialClosed:(VpadnInterstitial *)interstitial {
    [self adDidDismissFullscreen];
}

- (void) onVpadnInterstitialClicked:(VpadnInterstitial *)interstitial {
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
}

- (void) onVpadnInterstitialWillLeaveApplication:(VpadnInterstitial *)interstitial {
    [self adWillLeaveApplication];
}

@end

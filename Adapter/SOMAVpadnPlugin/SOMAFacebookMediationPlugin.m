//
//  SOMAAdMobPlugin.m
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 25.09.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SOMAFacebookMediationPlugin.h"
 

@implementation SOMAFacebookMediationPlugin
- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration *)network{
	self = [super initWithConfiguration:network];
	if (self) {
		 
	}
	return self;
}

- (void)dealloc{
     
}

- (void)load{
	if (self.network.adunitid == nil) {
		[self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"ca-app-pub-3940256099942544/6300978111\"}"];
		return;
	}
	
	
	if (self.isInterstitial) {
		[self loadInterstitial];
		return;
	}
	[FBAdSettings setLogLevel:FBAdLogLevelLog];
	FBAdSize adsize = kFBAdSizeHeight50Banner;
	if (self.somaBannerSize.height >= 250) {
		adsize = kFBAdSizeHeight250Rectangle;
	} else if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
		adsize = kFBAdSizeHeight90Banner;
	}
	
	[FBAdSettings addTestDevice:@"f7d4f77f85461abc718a28dbe95c6fb83b97e054"];
	FBAdView *adView = [[FBAdView alloc] initWithPlacementID:self.network.adunitid
													  adSize:adsize
										  rootViewController:[super rootViewController]];
	adView.delegate = self;
	[adView disableAutoRefresh];
	self.bannerView = adView;
	[self.bannerView loadAd];
}


- (void)loadInterstitial{
	self.interstitial = [[FBInterstitialAd alloc] initWithPlacementID:self.network.adunitid];
	self.interstitial.delegate = self;
	[self.interstitial loadAd];
}

- (void)presentInterstitial{
	[self.interstitial showAdFromRootViewController:[super rootViewController]];
}


#pragma mark - 
#pragma mark - FBAdViewDelegate
#pragma mark -
- (void)adViewDidClick:(nonnull FBAdView *)adView{
	[self adWillPresentFullscreen];
}
- (void)adViewDidFinishHandlingClick:(nonnull FBAdView *)adView{
	[self adDidDismissFullscreen];
}
- (void)adViewDidLoad:(nonnull FBAdView *)adView{
	[self adLoadedWithView:adView];
}
- (void)adView:(nonnull FBAdView *)adView didFailWithError:(nonnull NSError *)error{
	[self adLoadFailedWithError:error];
}
- (void)adViewWillLogImpression:(nonnull FBAdView *)adView{
}

#pragma mark -
#pragma mark - FBInterstitialAdDelegate
#pragma mark -
- (void)interstitialAdDidClick:(nonnull FBInterstitialAd *)interstitialAd{
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
	[self adWillLeaveApplication]; // not sure
}

- (void)interstitialAdDidClose:(nonnull FBInterstitialAd *)interstitialAd{
	[self adDidDismissFullscreen];
}

- (void)interstitialAdWillClose:(nonnull FBInterstitialAd *)interstitialAd{
}

- (void)interstitialAdDidLoad:(nonnull FBInterstitialAd *)interstitialAd{
	[self adLoadedWithView:nil];
}

- (void)interstitialAd:(nonnull FBInterstitialAd *)interstitialAd didFailWithError:(nonnull NSError *)error{
	[self adLoadFailedWithError:error];
}

- (void)interstitialAdWillLogImpression:(nonnull FBInterstitialAd *)interstitialAd{
	[self adWillPresentFullscreen]; // not sure
}

@end

//
//  SOMAAdMobPlugin.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 25.09.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface SOMAFacebookMediationPlugin : SOMAMediationPlugin<FBAdViewDelegate, FBInterstitialAdDelegate>
@property FBAdView* bannerView;
@property FBInterstitialAd* interstitial;
@end

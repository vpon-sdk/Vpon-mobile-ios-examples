//
//  SOMAFacebookNativeCSMPlugin.m
//  iSoma
//
//  Created by Aman Shaikh on 11.05.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SOMAFacebookNativeCSMPlugin.h"
#import "SOMANativeAdDto.h" 

static NSMutableDictionary* adChoicesViews = nil;
@interface SOMAFacebookNativeCSMPlugin()

@end

@implementation SOMAFacebookNativeCSMPlugin

- (instancetype)init{
    self = [super init];
    if (self) {
         
    }
    return self;
}
- (void)dealloc{
     
}
- (void)load{
    if (adChoicesViews == nil) {
        adChoicesViews = [NSMutableDictionary new];
    }
	
	[FBAdSettings setLogLevel:FBAdLogLevelLog];
	[FBAdSettings addTestDevice:@"f7d4f77f85461abc718a28dbe95c6fb83b97e054"];
    
	self.nativeAd = [[FBNativeAd alloc] initWithPlacementID:self.network.adunitid];
	self.nativeAd.delegate = self;
	[self.nativeAd loadAd];
}

- (void)registerViewForUserInteraction:(UIView*)view withRootViewController:(UIViewController*)rootViewController{
    UIView* tmp = adChoicesViews[[NSNumber numberWithUnsignedInteger:view.hash]];
    if (tmp) {
        [tmp removeFromSuperview];
        [adChoicesViews removeObjectForKey:[NSNumber numberWithUnsignedInteger:view.hash]];
    }
    
	FBAdChoicesView* adchoiseView = [[FBAdChoicesView alloc] initWithNativeAd:self.nativeAd];
	[view addSubview:adchoiseView];
	[adchoiseView updateFrameFromSuperview];
	[self.nativeAd registerViewForInteraction:view withViewController:rootViewController];
    
    adChoicesViews[[NSNumber numberWithUnsignedInteger:view.hash]] = adchoiseView;
}

- (void)nativeAdDidLoad:(FBNativeAd *)fbad{
	
	self.adCoverMediaView = [[FBMediaView alloc] initWithNativeAd:fbad];
	SOMANativeAdDTO* dto = [SOMANativeAdDTO new];
	dto.iconImageURL = fbad.icon.url;
	dto.callToAction = fbad.callToAction;
	dto.title = fbad.title;
	dto.text = fbad.body;
	dto.mediaView = self.adCoverMediaView;
	
	dto.starrating = 5*fbad.starRating.value/fbad.starRating.scale;
	
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidLoad:withDTO:)]) {
        [self.csmDelegate nativeCSMPluginDidLoad:self withDTO:dto];
    }
}

- (void)nativeAd:(FBNativeAd *)nativeAd didFailWithError:(NSError *)error{
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidFail:)]) {
        [self.csmDelegate nativeCSMPluginDidFail:self];
    }
}

- (void)nativeAdWillLogImpression:(FBNativeAd *)nativeAd{
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginLogImpresion:)]) {
        [self.csmDelegate nativeCSMPluginLogImpresion:self];
    }
}

- (void)nativeAdDidClick:(FBNativeAd *)nativeAd{
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginLogClick:)]) {
        [self.csmDelegate nativeCSMPluginLogClick:self];
    }
}
@end

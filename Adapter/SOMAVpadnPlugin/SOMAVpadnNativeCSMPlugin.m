//
//  SOMAVpadnNativeCSMPlugin.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/15.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "SOMAVpadnNativeCSMPlugin.h"

static NSMutableDictionary *adChoicesViews = nil;

@import VpadnSDKAdKit;

@interface SOMAVpadnNativeCSMPlugin() <VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAd *vponNativeAd;

@end

@implementation SOMAVpadnNativeCSMPlugin

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc{
    
}

- (void) load {
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    _vponNativeAd = [[VpadnNativeAd alloc] initWithBannerID:customData[@"AD_UNIT_ID"] platform:@"TW"];
    _vponNativeAd.delegate = self;
    [_vponNativeAd loadAd];
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

- (void)registerViewForUserInteraction:(UIView *)view withRootViewController:(UIViewController*)rootViewController {
    [self.vponNativeAd registerViewForInteraction:view withViewController:rootViewController];
}

#pragma mark VpadnNativeAdDelegate

- (void)onVpadnNativeAdReceived:(VpadnNativeAd *)nativeAd {
    SOMANativeAdDTO *dto = [SOMANativeAdDTO new];
    dto.iconImageURL = nativeAd.icon.url;
    dto.mainImageURL = nativeAd.coverImage.url;
    dto.callToAction = nativeAd.callToAction;
    dto.title = nativeAd.title;
    dto.text = nativeAd.body;
    dto.starrating = 5 * nativeAd.starRating.value / nativeAd.starRating.scale;
    
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidLoad:withDTO:)]) {
        [self.csmDelegate nativeCSMPluginDidLoad:self withDTO:dto];
    }
}

- (void)onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error {
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidFail:)]) {
        [self.csmDelegate nativeCSMPluginDidFail:self];
    }
}

@end

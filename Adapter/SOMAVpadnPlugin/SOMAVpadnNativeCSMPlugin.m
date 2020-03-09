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

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    return request;
}

- (void) load {
    NSDictionary *customData = [self parseCustomData:self.network.customClassData];
    _vponNativeAd = [[VpadnNativeAd alloc] initWithLicenseKey:customData[@"BANNER_ID"]];
    _vponNativeAd.delegate = self;
    [_vponNativeAd loadRequest:[self initialRequest]];
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

- (void) onVpadnNativeAdLoaded:(VpadnNativeAd *)nativeAd {
    SOMANativeAdObject *object = [SOMANativeAdObject nativeAdObjectWithURL:nativeAd.coverImage.url
                                                                     title:nativeAd.title
                                                           descriptionText:nativeAd.body
                                                                   CTAText:nativeAd.callToAction
                                                                    rating:5 * nativeAd.ratingValue / nativeAd.ratingScale];
    object.mediaView = [[VpadnMediaView alloc] initWithNativeAd:nativeAd];
    
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidLoad:withObject:)]) {
        [self.csmDelegate nativeCSMPluginDidLoad:self withObject:object];
    }
}

- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd failedToLoad:(NSError *)error {
    if ([self.csmDelegate respondsToSelector:@selector(nativeCSMPluginDidFail:)]) {
        [self.csmDelegate nativeCSMPluginDidFail:self];
    }
}

@end

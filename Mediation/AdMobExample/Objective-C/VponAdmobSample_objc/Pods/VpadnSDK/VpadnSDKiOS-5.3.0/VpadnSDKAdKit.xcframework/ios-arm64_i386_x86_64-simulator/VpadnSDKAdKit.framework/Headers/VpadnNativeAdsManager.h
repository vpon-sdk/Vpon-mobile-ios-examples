//
//  VpadnNativeAdsManager.h
//  iphone-vpon-sdk
//
//  Created by Mike Chou on 5/19/16.
//  Copyright © 2016 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VpadnNativeAd.h"

NS_ASSUME_NONNULL_BEGIN

@class VpadnNativeAdsManager;

@protocol VpadnNativeAdsManagerDelegate <NSObject>

/// 通知有廣告可供拉取 call back
- (void) onVpadnNativeAdsLoaded:(VpadnNativeAdsManager *)adsManager;
- (void) onVpadnNativeAdsReceived DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAdsLoaded: instead.");

/// 通知拉取廣告失敗 call back
- (void) onVpadnNativeAds:(VpadnNativeAdsManager *)adsManager failedToLoad:(NSError *)error;
- (void) onVpadnNativeAdsFailedToLoadWithError:(NSError *)error DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAds:failedToLoad: instead.");

@end

@interface VpadnNativeAdsManager : NSObject

/// Delegate token
@property (nonatomic, weak, nullable) id <VpadnNativeAdsManagerDelegate> delegate;

/// 廣告個數
@property (nonatomic, assign, readonly) NSUInteger uniqueNativeAdCount;

/// 版位ID (BannerID, PlacementID)
@property (nonatomic, copy, readonly) NSString *strBannerID;

/// 平台位置
@property (nonatomic, copy, readonly) NSString *platform;


/// 初始化方法
/// @param licenseKey 版位ID (BannerID, PlacementID)
/// @param numAdsRequested 取得的廣告個數
- (id) initWithLicenseKey:(NSString *)licenseKey forNumAdsRequested:(NSUInteger)numAdsRequested NS_DESIGNATED_INITIALIZER;

/// 取得廣告
- (void) loadRequest:(VpadnAdRequest *)request;

/// 廣告是否準備好
- (BOOL) isReady;

/// 取得下則廣告
- (nullable VpadnNativeAd *)nextNativeAd;

/// Deprecated intializer. Use initWithLicenseKey:forNumAdsRequested:.
- (id)initWithBannerID:(NSString *)bannerID platform:(NSString *)platform forNumAdsRequested:(NSUInteger)numAdsRequested DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:forNumAdsRequested:.");
/// Deprecated intializer. Use initWithLicenseKey:forNumAdsRequested:.
- (id)initWithBannerID:(NSString *)bannerID forNumAdsRequested:(NSUInteger)numAdsRequested DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:forNumAdsRequested:.");

/// Deprecated showTestLog method.
- (void) showTestLog:(BOOL)bShow DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated dontUseWVForNA method.
- (void) dontUseWVForNA DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated method. Use loadAds:.
- (void)loadAds DEPRECATED_MSG_ATTRIBUTE("Use loadAds:");

/// Deprecated method. Use loadAds:.
- (void)loadAdsWithTestIdentifiers:(NSArray *)arrayTestIdentifiers DEPRECATED_MSG_ATTRIBUTE("Use loadAds:");

@end

NS_ASSUME_NONNULL_END

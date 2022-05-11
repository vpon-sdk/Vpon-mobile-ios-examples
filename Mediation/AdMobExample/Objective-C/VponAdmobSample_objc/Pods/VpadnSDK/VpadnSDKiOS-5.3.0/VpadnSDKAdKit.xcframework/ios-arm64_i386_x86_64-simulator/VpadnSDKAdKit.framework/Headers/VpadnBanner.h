/**
 * @note Copyright (C) 2012~, Vpon Incorporated. All Rights Reserved.
 *       This program is an unpublished copyrighted work which is proprietary to
 *       Vpon Incorporated and contains confidential information that is
 *       not to be reproduced or disclosed to any other person or entity without
 *       prior written consent from Vpon, Inc. in each and every instance.
 *
 * @warning Unauthorized reproduction of this program as well as unauthorized
 *          preparation of derivative works based upon the program or distribution of
 *          copies by sale, rental, lease or lending are violations of federal
 *          copyright laws and state trade secret laws, punishable by civil and
 *          criminal penalties.
 *
 * @file    VpadnBanner.h
 *
 * @brief   support publisher to use Vpadn ad
 *
 *
 * @remark
 *
 **/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VpadnAdRequest.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark VpadnAdType
typedef enum {
	BANNER,
    RECTANGLE,
    PAD_BANNER,
    LEADERBOARD,
    SMART,
    STANDARD_PORTRAIT,
    SMART_PORTRAIT,
    CUSTOM_SIZE,
    INTERSTITIAL,
    SPLASH,
    MEDIUM_RECTANGLE,
    SMART_LANDSCAPE,
    VIDEO_INTERSTITIAL,
    NATIVE
} SizeTypeEnum;

#pragma mark VpadnAdSize
typedef struct  VpadnAdSize {
    CGSize size;
    CGSize showSize;
    int    adType;
}VpadnAdSize;

#pragma mark Standard Sizes

extern VpadnAdSize const VpadnAdSizeBanner;               // use for 320 * 50
extern VpadnAdSize const VpadnAdSizeLargeBanner;          // use for 320 * 100
extern VpadnAdSize const VpadnAdSizeLargeRectangle;       // use for 320 * 480   for iPad
extern VpadnAdSize const VpadnAdSizeFullBanner;           // use for 468 * 60   for iPad
extern VpadnAdSize const VpadnAdSizeLeaderboard;          // use for 728 * 90   for iPad
extern VpadnAdSize const VpadnAdSizeMediumRectangle;      // use for 300 * 250  for iPad
extern VpadnAdSize const VpadnAdSizeSmartBannerLandscape; // use for landscape smart banner
extern VpadnAdSize const VpadnAdSizeSmartBannerPortrait;  // use for portrait smart banner

#pragma mark Custom Sizes

VpadnAdSize VpadnAdSizeFromCGSize(CGSize size); // get banner size

@class VpadnBanner;

#pragma mark 插屏週期通知

@protocol VpadnBannerDelegate <NSObject>

@optional

/// 通知有廣告可供拉取 call back
- (void) onVpadnAdLoaded:(VpadnBanner *)banner;
- (void) onVpadnAdReceived:(UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnAdLoaded: instead.");

/// 通知拉取廣告失敗 call back
- (void) onVpadnAd:(VpadnBanner *)banner failedToLoad:(NSError *)error;
- (void) onVpadnAdFailed:(nullable UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error DEPRECATED_MSG_ATTRIBUTE("Please use onVponAd:failedToLoad: instead.");

/// 通知即將離開 application
- (void) onVpadnAdWillLeaveApplication:(VpadnBanner *)banner;
- (void) onVpadnLeaveApplication:(UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVponAdWillLeaveApplication: instead.");

/// 通知廣告即將被開啟
- (void) onVpadnAdWillOpen:(VpadnBanner *)banner;
- (void) onVpadnPresent:(UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnAdWillOpen: instead.");

/// 通知廣告已被關閉
- (void) onVpadnAdClosed:(VpadnBanner *)banner;
- (void) onVpadnDismiss:(UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnAdClosed: instead.");

/// 通知廣告已送出點擊事件
- (void) onVpadnAdClicked:(VpadnBanner *)banner;
- (void) onVpadnAdDidClicked:(VpadnBanner *)banner DEPRECATED_MSG_ATTRIBUTE("Please use onVponAdClicked: instead.");

/// 通知廣告將自動 refresh
- (void) onVpadnAdRefreshed:(VpadnBanner *)banner;
- (void) onVpadnAdWillRefresh:(VpadnBanner *)banner DEPRECATED_MSG_ATTRIBUTE("Please use onVponAdRefreshed: instead.");

- (void) onVpadnGetAd:(UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Not support.");
- (void) onVpadnViewSizeChange:(CGRect)ViewSize DEPRECATED_MSG_ATTRIBUTE("Not support.");
- (void) onVpadnViewColorChange:(UIColor*)bgColor DEPRECATED_MSG_ATTRIBUTE("Not support.");

@end

#pragma mark VpadnBanner

@interface VpadnBanner : NSObject

/// 版位ID (BannerID, PlacementID)
@property (nonatomic, copy) NSString *strBannerId;

/// 根控制項
@property (nonatomic, weak) UIViewController *rootViewController;

/// Delegate token
@property (nonatomic, weak) id<VpadnBannerDelegate> delegate;

/// 平台位置
@property (nonatomic, copy) NSString *platform;

/// 測試的IDFA
@property (nonatomic, copy) NSArray *arrayTestIdentifiers;

/// 初始化方法
/// @param licenseKey 版位ID (BannerID, PlacementID)
/// @param adSize 廣告Size
- (id) initWithLicenseKey:(NSString *)licenseKey adSize:(VpadnAdSize)adSize NS_DESIGNATED_INITIALIZER;

/// 取得廣告
- (void) loadRequest:(VpadnAdRequest *)request;

/// 取得廣告View
- (UIView *) getVpadnAdView;

#pragma mark

- (void) dealloc;

- (void) bannerPositionChange;

#pragma mark Convenience Functions

- (CGSize) CGSizeFromVpadnAdSize:(VpadnAdSize)adSize;

#pragma mark - Deprecated

- (id) init NS_UNAVAILABLE;

/// Deprecated intializer.
/// Use initWithLicenseKey:adSize: instead.
- (id) initWithAdSize:(VpadnAdSize)adSize DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:adSize: instead.");

/// Deprecated intializer.
/// Use initWithLicenseKey:adSize: instead.
- (id) initWithAdSize:(VpadnAdSize)adSize origin:(CGPoint)origin DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:adSize: instead.");

/// Deprecated intializer.
/// Use initWithLicenseKey:adSize: instead.
- (id) initWithAdSize:(VpadnAdSize)adSize origin:(CGPoint)origin AutoCenter:(BOOL)isAuto DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:adSize: instead.");

/// Deprecated method.
/// Use loadRequest: instead.
- (void) startGetAd:(NSArray *)arrayTestIdentifiers DEPRECATED_MSG_ATTRIBUTE("Use loadRequest: instead.");

/// Deprecated getVersionVpadn method.
/// Use VpadnAdRequest.sdkVersion instead.
+ (NSString *) getVersionVpadn DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.sdkVersion instead.");

/// Deprecated addKeyword method.
/// Use VpadnAdRequest.addKeyword: instead.
- (void) addKeyword:(NSString*)keyword DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.addKeyword: instead.");

/// Deprecated setAdAutoRefresh method.
/// Use VpadnAdRequest.setAutoRefresh: instead.
- (void) setAdAutoRefresh:(BOOL)bSetAutoRefresh DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setAutoRefresh: instead.");

/// Deprecated setUserInfoAge method.
/// Use VpadnAdRequest.setUserInfoAge: instead.
- (void) setUserInfoAge:(NSInteger)age DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoAge: instead.");

/// Deprecated setUserInfoBirthdayWithYear:Month:andDay: method.
/// Use VpadnAdRequest.setUserInfoBirthdayWithYear:Month:andDay: instead.
- (void) setUserInfoBirthdayWithYear:(NSInteger)year Month:(NSInteger)month andDay:(NSInteger)day DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoBirthdayWithYear:Month:andDay: instead.");

/// Deprecated setUserInfoGender method.
/// Use VpadnAdRequest.setUserInfoGender: instead.
- (void) setUserInfoGender:(VpadnUserGender)gender DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoGender: instead.");

/// Deprecated destroyBanner method.
- (void) destroyBanner DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated showTestLog method.
- (void) showTestLog:(BOOL)bShow DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated isInAppAD method.
- (BOOL) isInAppAD DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated isUseLocation method.
- (BOOL) isUseLocation DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated setLocationOnOff method.
- (void) setLocationOnOff:(BOOL)isOn DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

@end

NS_ASSUME_NONNULL_END

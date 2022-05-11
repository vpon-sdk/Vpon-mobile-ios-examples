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
* @file    VpadnNativeAd.h
*
* @brief   support publisher to use Vpadn ad
*
* @remark
*
**/

#import <UIKit/UIKit.h>

#import "VpadnAdRequest.h"
#import "VpadnAdEnumerator.h"

NS_ASSUME_NONNULL_BEGIN

@class VpadnNativeAd, VpadnAdImage;

/**
 VpadnNativeAd Delegate
 */
@protocol VpadnNativeAdDelegate <NSObject>

@optional

/// 通知有廣告可供拉取 call back
- (void) onVpadnNativeAdLoaded:(VpadnNativeAd *)nativeAd;
- (void) onVpadnNativeAdReceived:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAdLoaded: instead.");

/// 通知拉取廣告失敗 call back
- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd failedToLoad:(NSError *)error;
- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAd:failedToLoad: instead.");

/// 通知即將離開Application
- (void) onVpadnNativeAdWillLeaveApplication:(VpadnNativeAd *)nativeAd;
- (void) onVpadnNativeAdLeaveApplication:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAdWillLeaveApplication: instead.");

/// 通知廣告已送出曝光事件
- (void) onVpadnNativeAdDidImpression:(VpadnNativeAd *)nativeAd;

/// 通知廣告已送出點擊事件
- (void) onVpadnNativeAdClicked:(VpadnNativeAd *)nativeAd;
- (void) onVpadnNativeAdDidClicked:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnNativeAdClicked: instead.");

- (void) onVpadnNativeGetAd:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Not support.");
- (void) onVpadnNativeAdPresent:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Not support.");
- (void) onVpadnNativeAdDismiss:(VpadnNativeAd *)nativeAd DEPRECATED_MSG_ATTRIBUTE("Not support.");

@end

@interface VpadnNativeAd : NSObject<VpadnNativeAdDelegate>

/// Delegate token
@property (nonatomic, weak) id<VpadnNativeAdDelegate> delegate;

/// 版位ID (BannerID, PlacementID)
@property (nonatomic, copy, readonly) NSString *strBannerId;

/// 平台位置
@property (nonatomic, copy, readonly) NSString *platform;

/// Branding 圖片
@property (nonatomic, strong, readonly) VpadnAdImage *icon;

/// Campaign 圖片
@property (nonatomic, strong, readonly) VpadnAdImage *coverImage;

/// 星數得分
@property (nonatomic, assign, readonly) CGFloat ratingValue;

/// 星數範圍
@property (nonatomic, assign, readonly) NSInteger ratingScale;

/// 主標題
@property (nonatomic, copy, readonly) NSString *title;

/// 內文
@property (nonatomic, copy, readonly) NSString *body;

/// 點擊鈕文案
@property (nonatomic, copy, readonly) NSString *callToAction;

/// 副標題
@property (nonatomic, copy, readonly) NSString *socialContext;

/// 初始化方法
/// @param licenseKey 版位ID (BannerID, PlacementID)
- (id) initWithLicenseKey:(NSString *)licenseKey NS_DESIGNATED_INITIALIZER;

/// 取得廣告
- (void) loadRequest:(VpadnAdRequest *)request;

/// 執行點擊事件
- (void) clickHandler:(id)sender;

/// 廣告是否準備好
- (BOOL)isReady;

/// 向SDK註冊View為廣告Container，且View的所有物件均可被點擊觸發事件。
/// @param view 廣告Container
/// @param viewController 根控制項
- (void)registerViewForInteraction:(UIView *)view
                withViewController:(UIViewController *)viewController;

/// 向SDK註冊View為廣告Container，設定clickableViews中的元件能被點擊觸發事件。
/// @param view 廣告Container
/// @param viewController 根控制項
/// @param clickableViews 可點擊的元件
- (void)registerViewForInteraction:(UIView *)view
                withViewController:(UIViewController *)viewController
                withClickableViews:(NSArray *)clickableViews;

/// 向SDK取消註冊的Container及所有能被點擊的元件。
- (void)unregisterView;


#pragma mark Deprecated

/// Deprecated intializer.
/// Use initWithLicenseKey: instead.
- (id)initWithBannerID:(NSString *)bannerID DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey: instead.");

/// Deprecated intializer.
/// Use initWithLicenseKey: instead.
- (id)initWithBannerID:(NSString *)bannerID platform:(NSString *)platform DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey: instead.");

/// Deprecated method.
/// Use loadRequest: instead.
- (void) loadAd DEPRECATED_MSG_ATTRIBUTE("Use loadRequest: instead.");

/// Deprecated method.
/// Use loadRequest: instead.
- (void) loadAdWithTestIdentifiers:(NSArray *)arrayTestIdentifiers DEPRECATED_MSG_ATTRIBUTE("Use loadRequest: instead.");

/// Deprecated addKeyword method.
/// Use VpadnAdRequest.addKeyword: instead.
- (void) addKeyword:(NSString*)keyword DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.addKeyword: instead.");

/// Deprecated setUserInfoAge method.
/// Use VpadnAdRequest.setUserInfoAge: instead.
- (void) setUserInfoAge:(NSInteger)age DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoAge: instead.");

/// Deprecated setUserInfoBirthdayWithYear:Month:andDay: method.
/// Use VpadnAdRequest.setUserInfoBirthdayWithYear:Month:andDay: instead.
- (void) setUserInfoBirthdayWithYear:(NSInteger)year Month:(NSInteger)month andDay:(NSInteger)day DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoBirthdayWithYear:Month:andDay: instead.");

/// Deprecated setUserInfoGender method.
/// Use VpadnAdRequest.setUserInfoGender: instead.
- (void) setUserInfoGender:(VpadnUserGender)gender DEPRECATED_MSG_ATTRIBUTE("Use VpadnAdRequest.setUserInfoGender: instead.");

/// Deprecated showTestLog method.
- (void) showTestLog:(BOOL)bShow DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated dontUseWVForNA method.
- (void) dontUseWVForNA DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated setLocationOnOff method.
- (void) setLocationOnOff:(BOOL)isOn DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");


@end

@interface VpadnAdImage : NSObject

/**
 image's url
 */
@property (nonatomic, copy, readonly, nonnull) NSURL *url;

/**
 image's weight
 */
@property (nonatomic, assign, readonly) NSInteger width;

/**
 image's height
 */
@property (nonatomic, assign, readonly) NSInteger height;

/**
 initial method

 @param url image's url
 @param width image's weight
 @param height image's height
 @return VpadnAdImage Object
 */
- (instancetype)initWithURL:(NSURL *)url
                      width:(NSInteger)width
                     height:(NSInteger)height NS_DESIGNATED_INITIALIZER;

/**
 load image method

 @param block 成功執行的邏輯
 */
- (void)loadImageAsyncWithBlock:(nullable void (^)(UIImage * __nullable image))block;
@end

NS_ASSUME_NONNULL_END

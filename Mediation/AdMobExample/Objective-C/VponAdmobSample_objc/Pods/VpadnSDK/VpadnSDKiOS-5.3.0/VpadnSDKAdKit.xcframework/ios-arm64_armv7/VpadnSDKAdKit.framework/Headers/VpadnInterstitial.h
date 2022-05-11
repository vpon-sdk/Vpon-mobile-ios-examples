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
 * @file    VpadnInterstitial.h
 *
 * @brief   support publisher to use Vpadn ad
 *
 * @remark
 *
 **/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VpadnAdRequest.h"
#import "VpadnAdEnumerator.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark 插屏週期通知

@class VpadnInterstitial;

@protocol VpadnInterstitialDelegate <NSObject>

@optional

/// 通知有廣告可供拉取 call back
- (void) onVpadnInterstitialLoaded:(VpadnInterstitial *)interstitial;
- (void) onVpadnInterstitialAdReceived:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitialLoaded instead.");

/// 通知拉取廣告失敗 call back
- (void) onVpadnInterstitial:(VpadnInterstitial *)interstitial failedToLoad:(NSError *)error;
- (void) onVpadnInterstitialAdFailed:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitial:failedToLoad: instead.");

/// 通知即將離開Application
- (void) onVpadnInterstitialWillLeaveApplication:(VpadnInterstitial *)interstitial;
- (void) onVpadnInterstitialAdWillLeaveApplication:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitialWillLeaveApplication instead.");

/// 通知廣告即將被開啟
- (void) onVpadnInterstitialWillOpen:(VpadnInterstitial *)interstitial;
- (void) onVpadnInterstitialAdWillPresent:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitialWillOpen: instead.");

/// 通知廣告已被關閉
- (void) onVpadnInterstitialClosed:(VpadnInterstitial *)interstitial;
- (void) onVpadnInterstitialAdDismiss:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitialClosed: instead.");

/// 通知廣告已送出點擊事件
- (void) onVpadnInterstitialClicked:(VpadnInterstitial *)interstitial;
- (void) onVpadnInterstitialAdClicked DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnInterstitialClicked: instead.");


- (void) onVpadnInterstitialAdDidFailToPresent:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Not support.");
- (void) onVpadnInterstitialAdWillDismiss:(nullable UIView *)bannerView DEPRECATED_MSG_ATTRIBUTE("Not support.");

@end

@interface VpadnInterstitial : NSObject

/// Delegate token
@property (nonatomic, weak) id<VpadnInterstitialDelegate> delegate;

/// 版位ID (BannerID, PlacementID)
@property (nonatomic, copy) NSString *strBannerId;

/// 平台位置
@property (nonatomic, copy) NSString *platform;

/// 測試的IDFA
@property (nonatomic, copy) NSArray *arrayTestIdentifiers;

/// 廣告是否使用過
@property (nonatomic, readonly, assign) BOOL hasBeenUsed;

/// 初始化方法
/// @param licenseKey 版位ID (BannerID, PlacementID)
- (id) initWithLicenseKey:(NSString *)licenseKey NS_DESIGNATED_INITIALIZER;

/// 取得廣告
- (void) loadRequest:(VpadnAdRequest *)request;

/**
 顯示廣告

 @param rootViewCtrl 根控制項
 */
- (void) showFromRootViewController:(UIViewController *)rootViewCtrl;

/**
 廣告是否準備好

 @return 結果
 */
- (BOOL) isReady;

#pragma mark Deprecated

/// Deprecated intializer.
/// Use initWithLicenseKey:  instead.
- (id) init DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey: instead.");

/// Deprecated method.
/// Use loadRequest: instead.
- (void) getInterstitial:(NSArray *)arrayTestIdentifiers DEPRECATED_MSG_ATTRIBUTE("Use loadRequest: instead.");

/// Deprecated show method.
/// Use showFromRootViewController: instead.
- (void) show DEPRECATED_MSG_ATTRIBUTE("Use showFromRootViewController: instead.");

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

/// Deprecated isInAppAD method.
- (BOOL) isInAppAD DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated isUseLocation method.
- (BOOL) isUseLocation DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

/// Deprecated setLocationOnOff method.
- (void) setLocationOnOff:(BOOL)isOn DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");


@end

NS_ASSUME_NONNULL_END

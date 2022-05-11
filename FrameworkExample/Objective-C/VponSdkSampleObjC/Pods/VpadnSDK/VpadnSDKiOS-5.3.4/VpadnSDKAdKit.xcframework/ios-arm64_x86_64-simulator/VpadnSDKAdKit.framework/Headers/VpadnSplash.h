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
* @file    VpadnSplash.h
*
* @brief   support publisher to use Vpadn ad
*
* @remark
*
**/

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "VpadnAdRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class VpadnSplash;

typedef enum {
    Default, NonClick, OnlyClick,
} SplashClickType;


@protocol VpadnSplashDelegate <NSObject>

@optional

/// 通知有廣告可供拉取 call back
- (void) onVpadnSplashLoaded:(VpadnSplash *)vpadnSplash;
- (void) onVpadnSplashReceived:(VpadnSplash *)vpadnSplash DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnSplashLoaded: instead.");

/// 通知拉取廣告失敗 call back
- (void) onVpadnSplash:(VpadnSplash *)vpadnSplash failedToLoad:(NSError *)error;
- (void) onVpadnSplash:(VpadnSplash *)vpadnSplash didFailToReceiveAdWithError:(nullable NSError *)error DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnSplash:failedToLoad: instead.");

/// 通知廣告已送出點擊事件
- (void) onVpadnSplashClicked:(VpadnSplash *)vpadnSplash;

/// 通知即將離開Application
- (void) onVpadnSplashWillLeaveApplication:(VpadnSplash *)vpadnSplash;
- (void) onVpadnSplashLeaveApplication:(VpadnSplash *)vpadnSplash DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnSplashWillLeaveApplication: instead.");

/// 通知廣告被允許關閉
- (void) onVpadnSplashAllowToClose:(VpadnSplash *)vpadnSplash;
- (void) onVpadnSplashAllowToDismiss:(VpadnSplash *)vpadnSplash DEPRECATED_MSG_ATTRIBUTE("Please use onVpadnSplashAllowToClose: instead.");

@end

@interface VpadnSplash : NSObject

@property (nonatomic, assign, nullable) id<VpadnSplashDelegate> delegate;

@property (nonatomic, strong, nonnull) UIView *splashView;

/// 初始化方法
/// @param licenseKey 版位ID (BannerID, PlacementID)
/// @param targetView 加載在哪個目標
- (instancetype) initWithLicenseKey:(NSString *)licenseKey target:(nonnull UIView *)targetView NS_DESIGNATED_INITIALIZER;

/// 取得廣告
- (void) loadRequest:(VpadnAdRequest *)request;

/// 設置容忍時間
- (void) setEndurableSecond:(float)fSecond;

/// 取得廣告需倒數秒數
- (float) getExhibitionSecond;

/// 關閉廣告倒數
- (void) disableCountDown;

/*
 @note deprecated method
 */

- (instancetype)init NS_UNAVAILABLE;

/// Deprecated intializer.
/// Use initWithLicenseKey:target: instead.
- (id _Nullable ) initWithSplashId:(nonnull NSString *)strSplashId withTarget:(nonnull UIView *)targetView DEPRECATED_MSG_ATTRIBUTE("Use initWithLicenseKey:target: instead.");

/// Deprecated method.
/// Use loadRequest: instead.
- (void) loadSplashWithTestIdentifiers:(NSArray *_Nullable)arrayTestIdentifiers DEPRECATED_MSG_ATTRIBUTE("Use loadRequest: instead.");

/// Deprecated setTestMode method.
- (void) setTestMode:(BOOL)bTestMode DEPRECATED_MSG_ATTRIBUTE("Deprecated from SDK 5.0.0");

@end

NS_ASSUME_NONNULL_END

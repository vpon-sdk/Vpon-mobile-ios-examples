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
#import "VpadnBanner.h"

#pragma mark -
#pragma mark VpadnInterstitialDelegate

@protocol VpadnInterstitialDelegate <VpadnBannerDelegate>
@optional
#pragma mark 通知取得插屏廣告成功pre-fetch完成
- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView;
#pragma mark 通知取得插屏廣告失敗
- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView;
//#pragma mark 通知取得插屏廣告點擊
//- (void)onVpadnInterstitialPresent:(UIView *)bannerView;
#pragma mark 通知關閉vpadn廣告頁面
- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView;
- (void)onVpadnInterstitialAdClicked;
@end

@interface VpadnInterstitial : NSObject

@property (nonatomic, weak) id<VpadnInterstitialDelegate> delegate;
@property (nonatomic, copy) NSString *strBannerId;
@property (nonatomic, copy) NSArray* arrayTestIdentifiers;
@property (nonatomic, retain) NSString* platform;

- (id)init;
#pragma mark 取得插屏廣告
- (void)getInterstitial:(NSArray*)arrayTestIdentifiers;
#pragma mark - 顯示插屏廣告
- (void)show;
#pragma mark Log Switch (Default YES)
- (void)showTestLog:(BOOL)bShow;
#pragma mark 設定Location開關
- (void)setLocationOnOff:(BOOL)isOn;
#pragma mark  回傳Location狀態
- (BOOL)isUseLocation;
- (BOOL)isInAppAD;
#pragma mark isReady
- (BOOL)isReady;

#pragma mark - UserInfomation
#pragma mark 設定使用者資訊-年齡
- (void)setUserInfoAge:(NSInteger)age;
#pragma mark 設定使用者資訊-生日
- (void)setUserInfoBirthdayWithYear:(NSInteger)year Month:(NSInteger)month andDay:(NSInteger)day;
#pragma mark 設定使用者資訊-性別
- (void)setUserInfoGender:(UserInfoGender)gender;
#pragma mark 設定使用者資訊-關鍵字
- (void)addKeyword:(NSString*)keyword;

@end

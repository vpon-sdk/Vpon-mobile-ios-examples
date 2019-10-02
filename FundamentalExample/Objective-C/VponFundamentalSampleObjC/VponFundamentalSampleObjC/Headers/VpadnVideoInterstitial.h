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
 * @file    VpadnVideoInterstitial.h
 *
 * @brief   support publisher to use Vpadn ad
 *
 * @remark
 *
 **/

#import "VpadnInterstitial.h"

@interface VpadnVideoInterstitial : NSObject <VpadnInterstitialDelegate>

@property (nonatomic, assign) NSObject<VpadnInterstitialDelegate> *delegate;
@property (nonatomic, copy) NSString *strBannerId;
@property (nonatomic, copy) NSArray* arrayTestIdentifiers;
@property (nonatomic, retain) NSString* platform;
- (id)init;
#pragma mark 取得插屏廣告
- (void)getInterstitial:(NSArray*)arrayTestIdentifiers;
#pragma mark isReady
//- (BOOL)isReady;
#pragma mark - 顯示插屏廣告
- (void)show;
#pragma mark Log Switch (Default YES)
- (void)showTestLog:(BOOL)bShow;
#pragma mark 設定Location開關
- (void)setLocationOnOff:(BOOL)isOn;
#pragma mark  回傳Location狀態
- (BOOL)isUseLocation;

@end

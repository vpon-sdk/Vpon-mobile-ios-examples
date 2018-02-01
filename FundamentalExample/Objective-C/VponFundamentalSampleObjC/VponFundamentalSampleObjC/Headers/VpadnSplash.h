//
//  VpadnSplash.h
//  vpon-sdk
//
//  Created by vpon-MI on 2017/8/10.
//  Copyright © 2017年 com.vpon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class VpadnSplash;

typedef enum {
    Default, NonClick, OnlyClick,
} SplashClickType;


@protocol VpadnSplashDelegate <NSObject>

@optional

- (void)onVpadnSplashReceived:(nonnull VpadnSplash *)vpadnSplash;

- (void)onVpadnSplash:(nonnull VpadnSplash *)vpadnSplash didFailToReceiveAdWithError:(nullable NSError *)error;

- (void)onVpadnSplashClicked:(nonnull VpadnSplash *)vpadnSplash;

- (void)onVpadnSplashLeaveApplication:(nonnull VpadnSplash *)vpadnSplash;

- (void)onVpadnSplashAllowToDismiss:(nonnull VpadnSplash *)vpadnSplash;

@end

@interface VpadnSplash : NSObject

@property (nonatomic, assign, nullable) id<VpadnSplashDelegate> delegate;

@property (nonatomic, strong, nonnull) UIView *splashView;

/*!
 @method
 
 @abstract init splash method.
 */
- (id _Nullable ) initWithSplashId:(nonnull NSString *)strSplashId withTarget:(nonnull UIView *)targetView;

/*!
 @method
 
 @abstract load splash method.
 */
- (void) loadSplashWithTestIdentifiers:(NSArray *_Nullable)arrayTestIdentifiers;

/*!
 @method
 
 @abstract set endurable time.
 
 @param time how long is user can endure second.
 */
- (void) setEndurableSecond:(float)fSecond;

/*!
 @method
 
 @abstract get test ad.
 */
- (void) setTestMode:(BOOL)bTestMode;

/*!
 @method
 
 @abstract get exhibition second.
 */
- (float) getExhibitionSecond;

/*!
 @method
 
 @abstract hidden count down view.
 */
- (void) disableCountDown;

@end

//
//  VpadnInReadAd.h
//  vpon-sdk
//
//  Created by EricChien on 2018/10/2.
//  Copyright © 2018 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VpadnAdRequest.h"

@class VpadnVideoAdView;
@class VpadnInReadAd;

typedef enum VpadnInReadAdType {
    VpadnInReadAdTypeOfCustomAd,
    VpadnInReadAdTypeOfInScroll,
    VpadnInReadAdTypeOfInTable,
    VpadnInReadAdTypeOfInTableRepeat,
    VpadnInReadAdTypeOfInTableCustomAd
} VpadnInReadAdType;

NS_ASSUME_NONNULL_BEGIN

@protocol VpadnInReadAdDelegate <NSObject>

@optional

- (void)vpadnInReadAd:(VpadnInReadAd *)ad didFailLoading:(NSError *)error;

- (void)vpadnInReadAdWillLoad:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidLoad:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWillStart:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidStart:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWillStop:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidStop:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidPause:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidResume:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidMute:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidUnmute:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdCanExpand:(VpadnInReadAd *)ad withRatio:(CGFloat)ratio;

- (void)vpadnInReadAdWillExpand:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidExpand:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdCanCollapse:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWillCollapse:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidCollapse:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWasClicked:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidClickBrowserClose:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWillTakeOverFullScreen:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidTakeOverFullScreen:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdWillDismissFullscreen:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidDismissFullscreen:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdSkipButtonTapped:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdSkipButtonDidShow:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidReset:(VpadnInReadAd *)ad;

- (void)vpadnInReadAdDidClean:(VpadnInReadAd *)ad;

@end

@interface VpadnInReadAd : NSObject

/* interface type */
@property (nonatomic, assign) VpadnInReadAdType vpadnInReadAdType;

@property (nonatomic, assign) BOOL isLoaded;

@property (nonatomic, strong, nullable) NSIndexPath *indexPath;

@property (nonatomic, assign, nullable) id<VpadnInReadAdDelegate> delegate;

@property (nonatomic, strong) VpadnVideoAdView *videoAdView;

- (void) dealloc;

#pragma mark - Custom Ad

- (id _Nonnull) initWithPlacementId:(nonnull NSString *)placementId delegate:(nullable id<VpadnInReadAdDelegate>)delegate;

- (id _Nonnull) initWithPlacementId:(nonnull NSString *)placementId scrollView:(nonnull UIScrollView *)scrollView delegate:(nullable id<VpadnInReadAdDelegate>)delegate;

#pragma mark - infeed

- (id _Nonnull) initWithPlacementId:(nonnull NSString *)placementId placeholder:(nonnull UIView *)placeHolder heightConstraint:(nonnull NSLayoutConstraint *)constraint scrollView:(nonnull UIScrollView *)scrollView delegate:(nullable id<VpadnInReadAdDelegate>)delegate;

- (id _Nonnull) initWithPlacementId:(nonnull NSString *)placementId insertionIndexPath:(nonnull NSIndexPath *)indexPath tableView:(nonnull UITableView *)tableView delegate:(nullable id<VpadnInReadAdDelegate>)delegate;

- (id _Nonnull) initWithPlacementId:(nonnull NSString *)placementId insertionIndexPath:(nonnull NSIndexPath *)indexPath repeatMode:(BOOL)repeat tableView:(nonnull UITableView *)tableView delegate:(nullable id<VpadnInReadAdDelegate>)delegate;


#pragma mark - Common Method

- (void) loadAdWithTestIdentifiers:(NSArray *_Nullable)arrayTestIdentifiers;

#pragma mark - Methods for Custom Ad

- (UIView *_Nullable) videoView;

#pragma mark - Class Method

- (BOOL) isVideoAd:(NSIndexPath *)indexPath stride:(NSInteger)stride;

/// 設置ContentURL
/// @param contentURL 內容網址
- (void) setContentUrl:(NSString *)contentURL;

/// 設置ContentData
/// @param contentData 內容
- (void) setContentData:(NSDictionary *)contentData;

/// 新增ContentData
/// @param key 鍵
/// @param value 值
- (void) addContentDataWithKey:(NSString *)key value:(NSString *)value;

#pragma mark - Friendly Obstruction

/// 排除遮蔽偵測的視圖
- (void) addFriendlyObstruction:(UIView *)obstructView purpose:(VpadnFriendlyObstructionType)purpose description:(NSString *)description;


@end

NS_ASSUME_NONNULL_END

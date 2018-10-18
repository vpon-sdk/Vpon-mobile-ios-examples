//
//  VpadnVideoAdView.h
//  XMLParser
//
//  Created by EricChien on 2018/4/11.
//  Copyright © 2018年 Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

FOUNDATION_EXPORT NSString *const kVpadnVideoAdPlayerStateChangedNotification;
FOUNDATION_EXPORT NSString *const kVpadnVideoAdPlayerProgressChangedNotification;
FOUNDATION_EXPORT NSString *const kVpadnVideoAdPlayerLoadProgressChangedNotification;

@class VpadnVideoAdView;

typedef NS_ENUM(NSInteger, VpadnPlayerState) {
    VpadnPlayerStateBuffering = 1,
    VpadnPlayerStatePlaying   = 2,
    VpadnPlayerStateStopped   = 3,
    VpadnPlayerStatePause     = 4
};

@protocol VpadnVideoAdViewDelegate <NSObject>

@required

- (void)vpadnVideoAdViewDidLayoutSubviews:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdView:(VpadnVideoAdView *)adView didFailLoading:(NSError *)error;

- (void)vpadnVideoAdViewWillLoad:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidLoad:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWillStart:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidStart:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWillStop:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidStop:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidPause:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidResume:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidMute:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidUnmute:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewCanExpand:(VpadnVideoAdView *)adView withRatio:(CGFloat)ratio;

- (void)vpadnVideoAdViewWillExpand:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidExpand:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewCanCollapse:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWillCollapse:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidCollapse:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWasClicked:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidClickBrowserClose:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWillTakeOverFullScreen:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidTakeOverFullScreen:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewWillDismissFullscreen:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidDismissFullscreen:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewSkipButtonTapped:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewSkipButtonDidShow:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidReset:(VpadnVideoAdView *)adView;

- (void)vpadnVideoAdViewDidClean:(VpadnVideoAdView *)adView;

@end

@interface VpadnVideoAdView : UIView

@property (nonatomic, copy) NSString *document;
@property (nonatomic, assign) id<VpadnVideoAdViewDelegate> n_delegate;
@property (nonatomic, readonly) VpadnPlayerState state;
@property (nonatomic, readonly) CGFloat loadedProgress;     //緩衝進度 0 ~ 1
@property (nonatomic, readonly) CGFloat duration;           //視頻總時間(sec)
@property (nonatomic, readonly) CGFloat current;            //當前播放時間(sec)
@property (nonatomic, readonly) CGFloat progress;           //播放進度 0 ~ 1
@property (nonatomic) BOOL stopWhenAppDidEnterBackground;   //預設值 = YES
@property (nonatomic) BOOL paused;
@property (nonatomic) BOOL alwaysPass;

- (void) coveredDetect;
- (void) releasePlayer;
- (void) loadData;

- (void) resume;
- (void) pauseBySystem;

@end

@protocol VpadnVideoAdFullScreenViewDelegate <NSObject>

- (void) callForDismiss;

@end

@interface VpadnVideoAdFullScreenView : UIView

@property (nonatomic, assign) id <VpadnVideoAdFullScreenViewDelegate> delegate;

- (void) presentFullScreen;

- (id) initWithAVPlayer:(AVPlayerLayer *)playerLayer functionView:(UIView *)functionView deleaget:(id)delegate;

@end

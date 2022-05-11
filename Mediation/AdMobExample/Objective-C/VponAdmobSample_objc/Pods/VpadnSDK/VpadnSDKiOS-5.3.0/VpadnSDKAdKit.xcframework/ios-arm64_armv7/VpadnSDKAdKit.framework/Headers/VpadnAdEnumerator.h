//
//  VpadnAdEnumerator.h
//  vpon-sdk
//
//  Created by EricChien on 2019/4/12.
//  Copyright © 2019 com.vpon. All rights reserved.
//

#ifndef VpadnAdEnumerator_h
#define VpadnAdEnumerator_h


#endif /* VpadnAdEnumerator_h */

typedef NS_ENUM(NSInteger, VpadnLogTag) {
    VpadnLogTagDebug = 0,
    VpadnLogTagInfo,
    VpadnLogTagWarnning,
    VpadnLogTagError,
    VpadnLogTagNote,
};

typedef NS_ENUM(NSInteger, VpadnMediaSource) {
    VpadnMediaSourceNone = 0,
    VpadnMediaSourceNative,
    VpadnMediaSourceSplash,
};

typedef NS_ENUM(NSInteger, VpadnReceivedState) {
    VpadnReceivedStateFailed = 0,
    VpadnReceivedStateSuccess,
    VpadnReceivedStateNone,
};

typedef NS_ENUM(NSInteger, VpadnPlacementType) {
    VpadnPlacementTypeInline = 0,
    VpadnPlacementTypeInterstitial,
};

typedef NS_ENUM(NSInteger, VpadnForceOrientation) {
    VpadnForceOrientationPortrait = 0,
    VpadnForceOrientationLandScape,
    VpadnForceOrientationNone
};

typedef NS_ENUM(NSInteger, VpadnPlayerState) {
    VpadnPlayerStateBuffering = 1,
    VpadnPlayerStateLoaded    = 2,
    VpadnPlayerStatePlaying   = 3,
    VpadnPlayerStateStopped   = 4,
    VpadnPlayerStatePause     = 5,
    VpadnPlayerStateFailed    = 6
};

typedef NS_ENUM(NSInteger, VpadnPlayerSoundState) {
    VpadnPlayerSoundStateMute = 1,
    VpadnPlayerSoundStateUnMute = 2,
};

typedef NS_ENUM(NSInteger, VpadnPlayerTrack) {
    VpadnPlayerTrackBuffering,
    VpadnPlayerTrackLoaded,
    VpadnPlayerTrackUpdateTime,
    VpadnPlayerTrackStart,
    VpadnPlayerTrackFirstQuartile,
    VpadnPlayerTrackMidpoint,
    VpadnPlayerTrackThirdQuartile,
    VpadnPlayerTrackComplete,   //播放一次完，不再送
    VpadnPlayerTrackEnded, //每次播放完，都送
    VpadnPlayerTrackPlay,
    VpadnPlayerTrackPause,
    VpadnPlayerTrackStop,
    VpadnPlayerTrackReplay,
    VpadnPlayerTrackResume,
    VpadnPlayerTrackMute,
    VpadnPlayerTrackUnMute,
};

typedef NS_ENUM(NSInteger, DataType) {
    DataTypeVideo = 1,
    DataTypeVideoEx,
};

typedef NS_ENUM(NSInteger, VideoAdType) {
    VideoAdTypeVideo = 1,
    VideoAdTypeVideoBanner,
    VideoAdTypeVideoEx,
};

typedef NS_ENUM(NSInteger, VpadnPosition) {
    VpadnPositionNone,
    VpadnPositionTop,
    VpadnPositionBottom,
    VpadnPositionRight,
    VpadnPositionLeft,
    VpadnPositionMiddle,
    VpadnPositionFull,
};

typedef NS_ENUM(NSInteger, VpadnAdMode) {
    VpadnAdModeNone,
    VpadnAdModeOnlyVideo,
    VpadnAdModeOnlyWebview,
    VpadnAdModeVideoAndWebview,
};

typedef NS_ENUM(NSInteger, VpadnActionType) {
    VpadnActionTypeFB = 1,
    VpadnActionTypeMap,
    VpadnActionTypeRenRen,
    VpadnActionTypeWeibo,
    VpadnActionTypeTwitter,
    VpadnActionTypeOpenUrl,
    VpadnActionTypeOpenStore,
    VpadnActionTypePlaceCall,
    VpadnActionTypeSendSms,
    VpadnActionTypeLine,
};

typedef NS_ENUM(NSInteger, VpadnActionMode) {
    VpadnActionModeOneAction,
    VpadnActionModeTwoAction,
};

typedef NS_ENUM(NSInteger, VpadnCloseButton) {
    VpadnCloseButtonSmall,
    VpadnCloseButtonBig,
};

//
//  VpadnAdAudioManager.h
//  vpon-sdk
//
//  Created by Yi-Hsiang, Chien on 2020/11/18.
//  Copyright © 2020 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdAudioManager : NSObject

/// 是否由Application來控制Audio
@property (nonatomic, assign) BOOL isAudioApplicationManaged;

+ (instancetype) sharedInstance;

/// Application通知SDK即將播放影音或聲音。
- (void) noticeApplicationAudioWillStart;

/// Application通知SDK已結束播放影音或聲音。
- (void) noticeApplicationAudioDidEnded;

@end

NS_ASSUME_NONNULL_END

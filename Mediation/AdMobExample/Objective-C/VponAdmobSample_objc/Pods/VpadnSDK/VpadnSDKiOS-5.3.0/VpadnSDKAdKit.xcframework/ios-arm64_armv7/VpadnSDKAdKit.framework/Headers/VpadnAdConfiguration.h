//
//  VpadnAdConfiguration.h
//  vpon-sdk
//
//  Created by EricChien on 2019/9/28.
//  Copyright © 2019 com.vpon. All rights reserved.
//

#pragma mark SDK 基本通用設定.

#import <Foundation/Foundation.h>
#import "VpadnAdAudioManager.h"
#import "VpadnAdLogLevel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdConfiguration : NSObject

@property (nonatomic, assign) VpadnLogLevel logLevel;
 
@property (nonatomic, strong) VpadnAdAudioManager *audioManager;


+ (instancetype) sharedInstance;

/// 初始化SDK
- (void) initializeSdk;

@end

NS_ASSUME_NONNULL_END

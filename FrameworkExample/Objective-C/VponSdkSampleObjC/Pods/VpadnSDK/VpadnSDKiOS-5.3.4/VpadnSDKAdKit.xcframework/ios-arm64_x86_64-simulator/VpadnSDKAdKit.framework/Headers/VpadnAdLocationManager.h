//
//  VpadnAdLocationManager.h
//  vpon-sdk
//
//  Created by Yi-Hsiang, Chien on 2021/11/22.
//  Copyright © 2021 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdLocationManager : NSObject

/// SDK是否能使用Location
@property (nonatomic, assign) BOOL isEnable;

+ (instancetype) sharedInstance;

@end

NS_ASSUME_NONNULL_END

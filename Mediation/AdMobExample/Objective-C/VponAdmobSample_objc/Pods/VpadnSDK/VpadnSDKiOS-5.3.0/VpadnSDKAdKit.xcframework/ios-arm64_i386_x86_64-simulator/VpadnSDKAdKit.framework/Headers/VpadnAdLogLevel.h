//
//  VpadnAdLogLevel.h
//  vpon-sdk
//
//  Created by EricChien on 2019/9/28.
//  Copyright © 2019 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VpadnLogLevel) {
    VpadnLogLevelDebug = 0,
    VpadnLogLevelDefault = 1,
    VpadnLogLevelDontShow = 99,
};

@interface VpadnAdLogLevel : NSObject

@end

NS_ASSUME_NONNULL_END

//
//  VponAdapterConfiguration.h
//  VponMopubSampleObjC
//
//  Created by EricChien on 2019/2/20.
//  Copyright © 2019 Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPBaseAdapterConfiguration.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface VponAdapterConfiguration : MPBaseAdapterConfiguration

@end

NS_ASSUME_NONNULL_END

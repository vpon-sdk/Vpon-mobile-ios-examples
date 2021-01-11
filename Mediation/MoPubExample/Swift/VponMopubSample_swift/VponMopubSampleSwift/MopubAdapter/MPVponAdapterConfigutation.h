//
//  MPVponAdapterConfigutation.h
//  VponSdkSampleObjC
//
//  Created by Yi-Hsiang, Chien on 2020/12/16.
//  Copyright © 2020 Soul. All rights reserved.
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

@interface MPVponAdapterConfigutation : MPBaseAdapterConfiguration

@end

NS_ASSUME_NONNULL_END

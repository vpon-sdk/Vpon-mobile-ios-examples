//
//  VpadnAnalytics.h
//  VpadnAnalytics
//
//  Created by vpon-MI on 2015/3/25.
//  Copyright (c) 2015年 vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VATracker.h"
#import "VpadnDictionaryBuilder.h"

@interface VpadnAnalytics : NSObject
@property(nonatomic, assign) id<VATracker> defaultTracker;
+ (VpadnAnalytics *)sharedInstance;
- (void)setLicenseKey:(NSString*)strLicenseKey;
- (NSString*)getVersion;
@end

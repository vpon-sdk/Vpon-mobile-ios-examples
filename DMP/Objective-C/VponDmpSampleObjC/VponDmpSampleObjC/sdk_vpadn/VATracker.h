//
//  VATracker.h
//  VpadnAnalytics
//
//  Created by vpon-MI on 2015/3/25.
//  Copyright (c) 2015年 vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VATracker<NSObject>
- (void)send:(NSDictionary *)dicParameters;
- (void)sendLaunchEvent:(NSString*)customID;
@end

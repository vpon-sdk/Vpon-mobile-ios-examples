//
//  VpadnDictionaryBuilder.h
//  VpadnAnalytics
//
//  Created by vpon-MI on 2015/3/25.
//  Copyright (c) 2015年 vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EventType) {
    Event_Login         = 0,
    Event_PageView,
    Event_Category,
    Event_Item,
    Event_AddToCart,
    Event_Checkout,
    Event_EelementInteract,
    Event_Search,
    Event_Custom,
    Event_None      // end of event
};

@interface VpadnDictionaryBuilder : NSObject

- (NSMutableDictionary *)build;

+ (VpadnDictionaryBuilder *)createEventWithEventType:(EventType)etEventType
                                       customID:(NSString *)strCustomID
                                      extraData:(NSMutableDictionary *)dicExtraData;

+ (VpadnDictionaryBuilder *)createEventWithEventName:(NSString *)strEventName
                                       customID:(NSString *)strCustomID
                                      extraData:(NSMutableDictionary *)dicExtraData;

@end
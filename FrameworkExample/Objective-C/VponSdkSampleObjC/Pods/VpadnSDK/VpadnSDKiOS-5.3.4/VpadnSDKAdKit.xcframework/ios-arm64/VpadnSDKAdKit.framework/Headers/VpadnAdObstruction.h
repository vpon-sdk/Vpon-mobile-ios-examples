//
//  VpadnAdObstruction.h
//  vpon-sdk
//
//  Created by Yi-Hsiang, Chien on 2020/9/25.
//  Copyright © 2020 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VpadnAdRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdObstruction : NSObject

@property (nonatomic, weak) UIView *view;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) VpadnFriendlyObstructionType purpose;

- (NSString *) getPurposeString;

+ (VpadnFriendlyObstructionType) getVpadnPurpose:(NSInteger)integer;

@end

NS_ASSUME_NONNULL_END

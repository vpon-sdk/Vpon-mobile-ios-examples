//
//  VponUCB.h
//  vpon-sdk
//
//  Created by Yi-Hsiang, Chien on 2020/12/21.
//  Copyright © 2020 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VponConsentStatus) {
    VponConsentStatusUnknown = -1,
    VponConsentStatusNonPersonalized = 0,
    VponConsentStatusPersonalized = 1,
};

@interface VponUCB : NSObject

+ (instancetype) sharedInstance;

- (void) setConsentStatus:(VponConsentStatus)status;

@end

NS_ASSUME_NONNULL_END

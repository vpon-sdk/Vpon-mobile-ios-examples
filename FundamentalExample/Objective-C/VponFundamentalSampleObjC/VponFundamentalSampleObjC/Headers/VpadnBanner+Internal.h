//
//  VpadnBanner+Internal.h
//  iphone-vpon-sdk
//
//  Created by Mike Chou on 11/17/15.
//  Copyright © 2015 com.vpon. All rights reserved.
//

@interface VpadnBanner (Internal)

- (void)setUseCustomCache:(BOOL)bUseCache;

#pragma Fake UUID
- (void)setUseFakeUUID:(BOOL)bSetEnforceUseFakeUUID;
- (void)setFakeUUID:(NSString*)strTargetFakeUUID;
- (BOOL)getUseFakeUUID;

#pragma Extra data
- (void)addPublisherExtraData:(NSString*)strKey withValue:(NSString*)strValue;

- (void)execJS:(NSString *)strScript;

@end

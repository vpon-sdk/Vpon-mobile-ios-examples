//
//  VpadnInterstitial+Internal.h
//  iphone-vpon-sdk
//
//  Created by Mike Chou on 11/17/15.
//  Copyright © 2015 com.vpon. All rights reserved.
//

@interface VpadnInterstitial (Internal)

#pragma Fake UUID
- (void)setUseFakeUUID:(BOOL)bUseFakeUUID;
- (void)setFakeUUID:(NSString*)strTargetFakeUUID;

#pragma Extra data
- (void)addPublisherExtraData:(NSString*)strKey withValue:(NSString*)strValue;

@end

//
//  VpadnBanner+Internal.h
//  iphone-vpon-sdk
//
//  Created by Mike Chou on 11/17/15.
//  Copyright © 2015 com.vpon. All rights reserved.
//

@interface VpadnBanner (Internal)

#pragma For Debugger
- (void) loadDebugUrl:(NSURL *)url;

- (void) sendRequestGetAd;

#pragma Fake UUID

- (void)setUseFakeUUID:(BOOL)bSetEnforceUseFakeUUID;
- (void)setFakeUUID:(NSString*)strTargetFakeUUID;
- (void)execJS:(NSString *)strScript;

@end

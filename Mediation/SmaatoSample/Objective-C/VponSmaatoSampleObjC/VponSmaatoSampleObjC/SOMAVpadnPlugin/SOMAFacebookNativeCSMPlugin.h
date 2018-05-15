//
//  SOMAFacebookNativeCSMPlugin.h
//  iSoma
//
//  Created by Aman Shaikh on 11.05.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface SOMAFacebookNativeCSMPlugin : SOMANativeCSMPlugin<FBNativeAdDelegate>
@property FBNativeAd *nativeAd;
@property (strong, nonatomic) FBMediaView *adCoverMediaView;
@end

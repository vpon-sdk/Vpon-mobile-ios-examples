//
//  VpadnNativeAdView.h
//  NativeSample
//
//  Created by Mike Chou on 22/11/2016.
//  Copyright © 2016 Vpon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNativeAdRendering.h"

@interface MPVponNativeAdView : UIView <MPNativeAdRendering>

@property (weak, nonatomic) IBOutlet UIImageView *adIconImageView;
@property (weak, nonatomic) IBOutlet UIView *adCoverMediaView;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *adBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *adCallToActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContextLabel;

@end

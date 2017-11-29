//
//  VponSdkNativeCustomTabCell.h
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VpadnNativeAd;

@interface VponSdkNativeCustomTabCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet UIImageView *adCoverMedia;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;
@property (weak, nonatomic) IBOutlet UIButton *adAction;

@property (strong, nonatomic)VpadnNativeAd *nativeAd;

- (void)setNativeAd:(VpadnNativeAd *)nativeAd;

@end

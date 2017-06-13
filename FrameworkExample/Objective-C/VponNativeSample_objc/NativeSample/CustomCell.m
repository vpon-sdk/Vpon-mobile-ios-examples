//
//  NativeAdCell.m
//  iphone-vpon-sdk
//
//  Created by Mike Chou on 7/15/16.
//  Copyright © 2016 com.vpon. All rights reserved.
//

@import VpadnSDKAdKit;
#import "CustomCell.h"

@interface CustomCell()

@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;
@property (weak, nonatomic) IBOutlet UIButton *adAction;

@property (strong, nonatomic)VpadnNativeAd *nativeAd;

@end

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.adAction.titleLabel.minimumScaleFactor = 8.0/14.0;
    self.adAction.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.adTitle.minimumScaleFactor = 12.0/14.0;
    self.adTitle.adjustsFontSizeToFitWidth = YES;
    
    self.adSocialContext.minimumScaleFactor = 10.0/12.0;
    self.adSocialContext.adjustsFontSizeToFitWidth = YES;
    
    self.adBody.minimumScaleFactor = 8.0/10.0;
    self.adBody.adjustsFontSizeToFitWidth = YES;
    
}

- (void)setNativeAd:(VpadnNativeAd *)nativeAd {
    if (_nativeAd != nativeAd) {
        [_nativeAd unregisterView];
    }
    _nativeAd = nativeAd;
    self.adIcon.image = nil;
    
    __block typeof(self) safeSelf = self;
    [_nativeAd.icon loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
        safeSelf.adIcon.image = image;
    }];
    
    self.adTitle.text = [_nativeAd.title copy];
    self.adBody.text = [_nativeAd.body copy];
    self.adSocialContext.text = [_nativeAd.socialContext copy];
    [self.adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateNormal];
    [self.adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateHighlighted];
}

@end

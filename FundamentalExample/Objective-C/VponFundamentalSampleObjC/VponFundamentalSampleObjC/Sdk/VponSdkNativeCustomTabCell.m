//
//  VponSdkNativeCustomTabCell.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkNativeCustomTabCell.h"

@implementation VponSdkNativeCustomTabCell

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

//    Original Method
//    [nativeAd.coverImage loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
//        safeSelf.adCoverMedia.image = image;
//    }];
    
//    New Method
    [_adMediaView setNativeAd:nativeAd];
    _adMediaView.delegate = self;
    
    self.adTitle.text = [_nativeAd.title copy];
    self.adBody.text = [_nativeAd.body copy];
    self.adSocialContext.text = [_nativeAd.socialContext copy];
    [self.adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateNormal];
    [self.adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateHighlighted];
}

#pragma mark - VpadnMediaView Delegate

- (void) mediaViewDidLoad:(VpadnMediaView *)mediaView {
    NSLog(@"mediaViewDidLoad");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

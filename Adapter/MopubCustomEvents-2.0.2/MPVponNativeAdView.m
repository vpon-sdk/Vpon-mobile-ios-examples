//
//  VpadnNativeAdView.m
//  NativeSample
//
//  Created by Mike Chou on 22/11/2016.
//  Copyright © 2016 Vpon. All rights reserved.
//

#import "MPVponNativeAdView.h"
#import "MPNativeAdConstants.h"
#import "MPNativeAdRenderingImageLoader.h"

@implementation MPVponNativeAdView

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void) didMoveToSuperview {
    if (self.superview) {
        [self addConstraintToView:self];
    }
}

- (void) addConstraintToView:(UIView *)view {
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nativeAdView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"nativeAdView": view}]];
    
    [view.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nativeAdView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"nativeAdView": view}]];
}

- (UILabel *)nativeMainTextLabel {
    return _adBodyLabel;
}

- (UILabel *)nativeTitleTextLabel {
    return _adTitleLabel;
}

- (UIImageView *)nativeIconImageView {
    return _adIconImageView;
}

- (UIImageView *)nativeMainImageView {
    return _adCoverMediaView;
}

- (UILabel *)nativeCallToActionTextLabel {
    return _adCallToActionLabel;
}

+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"MPVponNativeAdView" bundle:nil];
}

- (void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader {

    NSString *socialContext = customProperties[@"socialContext"];
    self.adSocialContextLabel.text = socialContext;

}

@end

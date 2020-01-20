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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    // layout your views
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

//- (UIImageView *)nativePrivacyInformationIconImageView {
//    
//}

+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"MPVponNativeAdView" bundle:nil];
}

- (void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader {

    NSString *socialContext = customProperties[@"socialContext"];
    self.adSocialContextLabel.text = socialContext;

}

@end

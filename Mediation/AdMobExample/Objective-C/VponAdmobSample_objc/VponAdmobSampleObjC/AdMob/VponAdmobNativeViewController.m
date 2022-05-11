//
//  VponAdmobNativeViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2018/10/25.
//  Copyright © 2018 Soul. All rights reserved.
//

#import "VponAdmobNativeViewController.h"
#import "VponAdmobNative.h"

@import GoogleMobileAds;

@interface VponAdmobNativeViewController () <GADNativeAdLoaderDelegate>

@property (strong, nonatomic) GADAdLoader *adLoader;

@property (weak, nonatomic) IBOutlet UIImageView *adIcon;

@property (weak, nonatomic) IBOutlet UILabel *adTitle;

@property (weak, nonatomic) IBOutlet UILabel *adBody;

@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;

@property (weak, nonatomic) IBOutlet UIButton *adAction;

@property (weak, nonatomic) IBOutlet GADMediaView *adMediaView;

@property (weak, nonatomic) IBOutlet GADAdChoicesView *adChoicesView;

@property (weak, nonatomic) IBOutlet VponAdmobNative *nativeAdView;

@property (weak, nonatomic) IBOutlet UIView *adContainerView;

//@property (weak, nonatomic) IBOutlet UIView *obstructView;

@end

@implementation VponAdmobNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Admob - Native";
}

- (IBAction) request:(id)sender {
    GADNativeAdViewAdOptions *adOptions = [[GADNativeAdViewAdOptions alloc] init];
    adOptions.preferredAdChoicesPosition = GADAdChoicesPositionTopRightCorner;
    
    _adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-7987617251221645/4222032724"
                                   rootViewController:self
                                              adTypes:@[GADAdLoaderAdTypeNative]
                                              options:@[adOptions]];
    _adLoader.delegate = self;
    
    GADRequest *request = [GADRequest request];
//    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];
//    [extra setExtras:@{
//        @"contentURL": @"https://www.google.com.tw/",
//        @"contentData": @{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)},
//        @"friendlyObstructions": @[@{ @"view": _obstructView, @"purpose": @(2), @"desc": @"not_visible"}]
//    } forLabel:@"Vpon"];
//    [request registerAdNetworkExtras:extra];
    
    [_adLoader loadRequest:request];
}

- (void)setNativeAd:(GADNativeAd *)nativeAd {
    
    VponAdmobNative *nativeAdView = [[NSBundle mainBundle] loadNibNamed:@"VponAdmobNative" owner:nil options:nil].firstObject;
    [self setAdView:nativeAdView];
    
    nativeAdView.mediaView.mediaContent = nativeAd.mediaContent;
    nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFit;
    
    ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
    ((UILabel *)nativeAdView.advertiserView).text = nativeAd.advertiser;
    
    ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
    
    [((UIButton *)nativeAdView.callToActionView)setTitle:nativeAd.callToAction forState:UIControlStateNormal];
    nativeAdView.callToActionView.userInteractionEnabled = NO;
    
    nativeAdView.nativeAd = nativeAd;
}

- (void)setAdView:(GADNativeAdView *)view {
    [_nativeAdView removeFromSuperview];
    _nativeAdView = (VponAdmobNative *)view;
    
    [_adContainerView addSubview:view];
    
    [_nativeAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_nativeAdView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nativeAdView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nativeAdView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
}

#pragma mark GADNativeAdLoaderDelegate implementation

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull NSError *)error {
    NSLog(@"Failed to receive native with error: %@", [error localizedFailureReason]);
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADNativeAd *)nativeAd {
    NSLog(@"Received native ad successfully");
    [self setNativeAd:nativeAd];
}

@end

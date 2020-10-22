//
//  VponAdmobNativeViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2018/10/25.
//  Copyright © 2018 Soul. All rights reserved.
//

#import "VponAdmobNativeViewController.h"

@import GoogleMobileAds;

@interface VponAdmobNativeViewController () <GADUnifiedNativeAdLoaderDelegate, GADVideoControllerDelegate, GADUnifiedNativeAdDelegate>

@property (nonatomic, strong) GADAdLoader *adLoader;

/// The native ad view that is being presented.
@property(nonatomic, strong) GADUnifiedNativeAdView *nativeAdView;

/// The height constraint applied to the ad view, where necessary.
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation VponAdmobNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLabel.text = [GADRequest sdkVersion];
    
    NSArray *nibObjects =
    [[NSBundle mainBundle] loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil];
    [self setAdView:[nibObjects firstObject]];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-7987617251221645/4222032724"
                                       rootViewController:self
                                                  adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                                                  options:@[]];
    self.adLoader.delegate = self;
    
    [self requestButtonDidTouch:_requestButton];
}

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    
    GADRequest *request = [GADRequest request];
//    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];
//    [extra setExtras:@{
//        @"contentURL": @"https://www.google.com.tw/",
//        @"contentData": @{@"key1": @(1), @"key2": @(YES), @"key3": @"name", @"key4": @(123.31)},
//        @"friendlyObstructions": @[@{ @"view": [[UIView alloc] init], @"purpose": @(2), @"desc": @"not_visible"}]
//    } forLabel:@"Vpon"];
//    [request registerAdNetworkExtras:extra];
//    request.testDevices = @[kGADSimulatorID];
    
    [self.adLoader loadRequest:request];
}

- (void)setAdView:(GADUnifiedNativeAdView *)view {
    // Remove previous ad view.
    [self.nativeAdView removeFromSuperview];
    self.nativeAdView = view;
    
    // Add new ad view and set constraints to fill its container.
    [self.nativeAdPlaceholder addSubview:view];
    [self.nativeAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
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

#pragma mark GADUnifiedNativeAdLoaderDelegate implementation

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
    self.requestButton.enabled = YES;
    
    GADUnifiedNativeAdView *nativeAdView = self.nativeAdView;
    
    // Deactivate the height constraint that was set when the previous video ad loaded.
    self.heightConstraint.active = NO;
    
    nativeAdView.nativeAd = nativeAd;
    
    // Set ourselves as the ad delegate to be notified of native ad events.
    nativeAd.delegate = self;
    
    // Populate the native ad view with the native ad assets.
    // Some assets are guaranteed to be present in every native ad.
    ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
    [((UIButton *)nativeAdView.callToActionView)setTitle:nativeAd.callToAction
                                                forState:UIControlStateNormal];
    
    // Some native ads will include a video asset, while others do not. Apps can
    // use the GADVideoController's hasVideoContent property to determine if one
    // is present, and adjust their UI accordingly.
    if (nativeAd.videoController.hasVideoContent) {
        // This app uses a fixed width for the GADMediaView and changes its height
        // to match the aspect ratio of the video it displays.
        if (nativeAd.videoController.aspectRatio > 0) {
            self.heightConstraint =
            [NSLayoutConstraint constraintWithItem:nativeAdView.mediaView
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nativeAdView.mediaView
                                         attribute:NSLayoutAttributeWidth
                                        multiplier:(1 / nativeAd.videoController.aspectRatio)
                                          constant:0];
            self.heightConstraint.active = YES;
        }
        
        // By acting as the delegate to the GADVideoController, this ViewController
        // receives messages about events in the video lifecycle.
        nativeAd.videoController.delegate = self;
        
        self.videoStatusLabel.text = @"Ad contains a video asset.";
    } else {
        self.videoStatusLabel.text = @"Ad does not contain a video.";
    }
    
    // These assets are not guaranteed to be present, and should be checked first.
    ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
    if (nativeAd.icon != nil) {
        nativeAdView.iconView.hidden = NO;
    } else {
        nativeAdView.iconView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.storeView).text = nativeAd.store;
    if (nativeAd.store) {
        nativeAdView.storeView.hidden = NO;
    } else {
        nativeAdView.storeView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.priceView).text = nativeAd.price;
    if (nativeAd.price) {
        nativeAdView.priceView.hidden = NO;
    } else {
        nativeAdView.priceView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.advertiserView).text = nativeAd.advertiser;
    if (nativeAd.advertiser) {
        nativeAdView.advertiserView.hidden = NO;
    } else {
        nativeAdView.advertiserView.hidden = YES;
    }
    
    // In order for the SDK to process touch events properly, user interaction
    // should be disabled.
    nativeAdView.callToActionView.userInteractionEnabled = NO;
}

#pragma mark GADVideoControllerDelegate implementation

- (void)videoControllerDidEndVideoPlayback:(GADVideoController *)videoController {
    self.videoStatusLabel.text = @"Video playback has ended.";
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    _requestButton.enabled = YES;
    NSLog(@"Failed to receive native with error: %@", [error localizedFailureReason]);
}

@end

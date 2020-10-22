//
//  VponMopubNativeViewController.m
//  VponMopubSampleObjC
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponMopubNativeViewController.h"

#import <MoPub.h>
#import "MPVponNativeCustomEvent.h"

#import "MPVponNativeAdView.h"

@interface VponMopubNativeViewController () <MPNativeAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadNativeView;

@property (strong, nonatomic) MPNativeAd *mpNativeAd;

@end

@implementation VponMopubNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MoPub - Native";
    [self requestButtonDidTouch:self.requestButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    #warning create a custom view for your business
    settings.renderingViewClass = [MPVponNativeAdView class];
    
    MPNativeAdRendererConfiguration *config = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
    config.supportedCustomEvents = @[@"MPVponNativeCustomEvent"];
    
    #warning set ad unit id
    MPNativeAdRequest *adRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:@"ddeaeccecddf44cea7732465a9138239" rendererConfigurations:@[config]];
    
    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, nil];
//    targeting.localExtras = @{
//        @"contentURL": @"https://www.vpon.com",
//        @"contentData": @{@"key1": @"Mopub", @"key2": @(1.2), @"key3": @(YES)},
//        @"friendlyObstructions": @[@{ @"view": [[UIView alloc] init], @"purpose": @(2), @"desc": @"not_visible"}]
//    };
    adRequest.targeting = targeting;
    
    __block typeof(self) weakSelf = self;
    [adRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"Failed to receive native with error : %@", error.localizedFailureReason);
        } else {
            weakSelf.mpNativeAd = response;
            weakSelf.mpNativeAd.delegate = weakSelf;
            UIView *nativeAdView = [response retrieveAdViewWithError:nil];
            nativeAdView.frame = weakSelf.loadNativeView.bounds;
            [weakSelf.loadNativeView addSubview:nativeAdView];
        }
        weakSelf.requestButton.enabled = YES;
    }];
}

#pragma mark MPNativeAd Delegate

-(UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)willPresentModalForNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"willPresentModalForNativeAd");
}

- (void)didDismissModalForNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"didDismissModalForNativeAd");
}

- (void)willLeaveApplicationFromNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"willLeaveApplicationFromNativeAd");
}

@end

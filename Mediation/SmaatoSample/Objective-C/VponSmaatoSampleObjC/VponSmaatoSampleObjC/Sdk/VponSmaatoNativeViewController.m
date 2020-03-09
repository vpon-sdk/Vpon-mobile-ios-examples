//
//  VponSmaatoNativeViewController.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/15.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "VponSmaatoNativeViewController.h"
#import <iSoma/iSoma.h>

@interface VponSmaatoNativeViewController () <SOMANativeAdDelegate>

@property IBOutlet UILabel *nativeAdCallToAction;
@property IBOutlet UILabel *status;
@property IBOutlet UIView *nativeAdView;
@property IBOutlet UILabel *nativeAdTitle;
@property IBOutlet UILabel *nativeAdDescription;
@property IBOutlet UIImageView *nativeAdIcon;
@property IBOutlet UIView *nativeAdImage;

@property SOMANativeAd* nativeAd;

@end

@implementation VponSmaatoNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SMAATO - Native";
    
    self.nativeAdView.hidden = YES;
    
#warning Publisher id & ad Space id
    SOMANativeAd* nativeAd = [[SOMANativeAd alloc] initWithPublisherId:@"1100040241" adSpaceId:@"130399759"];
    nativeAd.delegate = self;
    nativeAd.labelForTitle = self.nativeAdTitle;
    nativeAd.labelForDescription = self.nativeAdDescription;
    nativeAd.viewForMainImage = self.nativeAdImage;
    [nativeAd load];
    self.nativeAd = nativeAd;
    
    UIBarButtonItem* reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onReload:)];
    self.navigationItem.rightBarButtonItem = reload;
}

- (void)onReload:(id)sender{
    self.status.text = @"Loading native ad...";
    [self.nativeAd load];
}

#pragma mark - SOMANativeAdDelegate

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd{
    self.status.text = @"Native ad loaded!";
    self.nativeAdCallToAction.text = nativeAd.callToAction;
    self.nativeAdView.alpha = 0;
    self.nativeAdView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.nativeAdView.alpha = 1;
    } completion:^(BOOL finished) {
        [nativeAd registerViewForUserInteraction:self.nativeAdView];
    }];
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error{
    self.status.text = @"No ad available";
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd {
    self.status.text = @"Native ad clicked";
    [UIView animateWithDuration:0.3 animations:^{
        self.nativeAdView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

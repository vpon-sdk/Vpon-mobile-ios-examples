//
//  VponSmaatoInterstitialViewController.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/11.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "VponSmaatoInterstitialViewController.h"
#import <iSoma/iSoma.h>

@interface VponSmaatoInterstitialViewController () <SOMAAdViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic) BOOL canShow;

@property (strong, nonatomic) SOMAInterstitialAdView *interstitialAd;

@end

@implementation VponSmaatoInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SMAATO - Interstitial";
    [self actionButtonDidTouch:self.actionButton];
}

#pragma mark - Button Method

- (IBAction)actionButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    if (self.interstitialAd != nil && self.canShow) {
        [self.interstitialAd show];
    } else {
        self.canShow = NO;
        if (self.interstitialAd == nil) {
            self.interstitialAd = [SOMAInterstitialAdView new];
#warning Publisher id & ad Space id
            self.interstitialAd.adSettings.publisherId = 1100040241;
            self.interstitialAd.adSettings.adSpaceId = 130399758;
            self.interstitialAd.delegate = self;
        }
        [self.interstitialAd load];
    }
}

#pragma mark - SOMAAdViewDelegate

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
    NSLog(@"PUBLISHER> Ad View Will Load");
    
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    NSLog(@"PUBLISHER> Ad View Loaded");
    self.canShow = YES;
    self.actionButton.enabled = YES;
    [self.actionButton setTitle:@"show" forState:UIControlStateNormal];
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
    if (self.interstitialAd.isNewAdAvailable  == false || self.interstitialAd.isAdShown == true) {
        self.canShow = NO;
        self.actionButton.enabled = YES;
        [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
    }
    BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
    int reloadInterval = adview.adSettings.autoReloadInterval;
    NSString* reloadTimeMessage = @"";
    if (reloadEnabled) {
        reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
    }
    NSLog(@"AdView failed to load: %@", [error localizedDescription]);
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
    NSLog(@"PUBLISHER> Exited full screen");
}

- (void)somaAdViewWillHide:(SOMAAdView*)adview{
    NSLog(@"PUBLISHER> Ad view will hide");
    self.actionButton.enabled = YES;
    self.interstitialAd = nil;
    [self.actionButton setTitle:@"request" forState:UIControlStateNormal];
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

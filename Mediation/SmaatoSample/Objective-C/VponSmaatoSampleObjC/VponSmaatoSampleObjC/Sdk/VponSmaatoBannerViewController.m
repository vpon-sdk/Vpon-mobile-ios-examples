//
//  VponSmaatoBannerViewController.m
//  VponSmaatoSampleObjC
//
//  Created by EricChien on 2018/5/11.
//  Copyright © 2018年 vpon. All rights reserved.
//

#import "VponSmaatoBannerViewController.h"
#import <iSoma/iSoma.h>

@interface VponSmaatoBannerViewController () <SOMAAdViewDelegate>

@property (nonatomic, strong) SOMAAdView *adView;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end

@implementation VponSmaatoBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SMAATO - Banner";
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestButtonDidTouch:self.requestButton];
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if ([self.loadBannerView.subviews containsObject:_adView]) {
        _adView.frame = self.loadBannerView.bounds;
    } else {
        _adView = [[SOMAAdView alloc] initWithFrame:self.loadBannerView.bounds];
        _adView.delegate = self;
#warning Publisher id & ad Space id
        _adView.adSettings.publisherId = 1100040241;
        _adView.adSettings.adSpaceId = 130399757;
        _adView.adSettings.httpsOnly = YES;
        _adView.adSettings.autoReloadInterval  = 30;
        _adView.adSettings.type = SOMAAdTypeRichMedia;
        _adView.adSettings.dimension = SOMAAdDimensionXXLARGE;
        _adView.shouldAppearAutomatically = YES;
        [self.loadBannerView addSubview:_adView];
    }
    
    [_adView load];
}

#pragma mark - SOMAAdViewDelegate

- (UIViewController *) somaRootViewController {
    return self;
}

- (void) somaAdViewWillLoadAd:(SOMAAdView*)adview{
    NSLog(@"Ad View Will Load");
}

- (void) somaAdViewDidLoadAd:(SOMAAdView*)adview{
    self.requestButton.enabled = YES;
}

- (void) somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
    self.requestButton.enabled = YES;
    
    BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
    int reloadInterval = adview.adSettings.autoReloadInterval;
    NSString* reloadTimeMessage = @"";
    if (reloadEnabled) {
        reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
    }
    NSLog(@"AdView failed to load: %@", [error localizedDescription]);
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

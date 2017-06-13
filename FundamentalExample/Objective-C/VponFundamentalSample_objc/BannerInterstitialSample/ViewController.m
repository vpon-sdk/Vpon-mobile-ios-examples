//
//  ViewController.m
//  BannerInterstitialSample
//
//  Created by Mike Chou on 10/28/15.
//  Copyright © 2015 Vpon. All rights reserved.
//

#import "ViewController.h"
#import "VpadnBanner.h"
#import "VpadnInterstitial.h"

@interface ViewController ()<VpadnBannerDelegate, VpadnInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIButton *showInterstitialBtn;

@property (nonatomic, strong) VpadnBanner *bannerAd;
@property (nonatomic, strong) VpadnInterstitial *interstitialAd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Show the sdk version on the screen.
    self.versionLabel.text = [NSString stringWithFormat:@"version: %@", [VpadnBanner getVersionVpadn]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Custom Action

- (IBAction)showBannerAd:(id)sender {
    
    // create an CGPoint origin for the banner to show in the middle of the bannerView
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGPoint origin = CGPointMake((screenWidth - VpadnAdSizeBanner.size.width)/2.0f , 0);
    
    // Set up bannerAd
    _bannerAd = [[VpadnBanner alloc] initWithAdSize:VpadnAdSizeBanner origin:origin];
    _bannerAd.strBannerId = @""; // 填入您的BannerId
    _bannerAd.platform = @"TW"; // 台灣地區請填TW 大陸則填CN
    _bannerAd.delegate = self;
    [_bannerAd setAdAutoRefresh:YES];
    [_bannerAd setRootViewController:self];
    [self.bannerView addSubview:[_bannerAd getVpadnAdView]];
    [_bannerAd startGetAd:[self getTestIdentifiers]];
}

- (IBAction)getInterstitialAd:(id)sender {
    
    // Set up interstitialAd
    _interstitialAd = [[VpadnInterstitial alloc] init];
    _interstitialAd.strBannerId = @""; // 填入您的Interstitial BannerId
    _interstitialAd.platform = @"TW"; // 台灣地區請填TW 大陸則填CN
    _interstitialAd.delegate = self;
    [_interstitialAd getInterstitial:[self getTestIdentifiers]];
}

- (IBAction)showInterstitialAd:(id)sender {
    
    // Show interstitialAd
    [_interstitialAd show];
    [_showInterstitialBtn setHidden:YES];
}

- (NSArray *)getTestIdentifiers{
    return [NSArray arrayWithObjects:
            // add your test UUID
            nil];
}

#pragma mark VpadnBannerDelegate
- (void)onVpadnGetAd:(UIView *)bannerView
{
    NSLog(@"開始抓取廣告");
}

- (void)onVpadnAdReceived:(UIView *)bannerView{
    NSLog(@"廣告抓取成功");
}

- (void)onVpadnAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"廣告抓取失敗 %@", error);
}

- (void)onVpadnDismiss:(UIView *)bannerView{
    
    NSLog(@"關閉vpadn廣告頁面 %@",bannerView);
}

- (void)onVpadnLeaveApplication:(UIView *)bannerView{
    
    NSLog(@"離開publisher application");
}

- (void)onVpadnPresent:(UIView *)bannerView{
    
    if (bannerView == [_bannerAd getVpadnAdView]) {
        NSLog(@"Banner 開啟vpadn廣告頁面 %d %@",[_bannerAd isInAppAD], bannerView);
    } else {
        NSLog(@"Interstitial 開啟vpadn廣告頁面 %d %@",[_interstitialAd isInAppAD], bannerView);
    }
}

#pragma mark VpadnInterstitialDelegate
- (void)onVpadnInterstitialAdReceived:(UIView *)bannerView{
    NSLog(@"插屏廣告抓取成功");
    [_showInterstitialBtn setHidden:NO];
}

- (void)onVpadnInterstitialAdFailed:(UIView *)bannerView{
    NSLog(@"插屏廣告抓取失敗");
}

- (void)onVpadnInterstitialAdDismiss:(UIView *)bannerView{
    NSLog(@"關閉插屏廣告頁面 %@",bannerView);
}

@end

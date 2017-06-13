//
//  ViewController.m
//  MangoDemo
//
//  Created by Chenchung Wu on 2014/12/9.
//  Copyright (c) 2014年 Chenchung Wu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
- (IBAction)showInterstitial:(id)sender {
    
    [[AdMoGoInterstitialManager shareInstance]interstitialShow:YES];
}
- (IBAction)CancelInterstitial:(id)sender {
    [[AdMoGoInterstitialManager shareInstance]interstitialCancel];
}

@synthesize adView;
- (void)dealloc
{
    adView.delegate = nil;
    adView.adWebBrowswerDelegate = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    adView = [[AdMoGoView alloc] initWithAppKey:@""
                                         adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:self];
    adView.adWebBrowswerDelegate = self;
    
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth=[[UIScreen mainScreen] bounds].size.width;

    if (screenWidth > 320) {
        adView.frame = CGRectMake((screenWidth-320)/2, screenHeight-50 , 320, 50.0);
    }
    
    else
    {
        adView.frame = CGRectMake(0, screenHeight-50 , 320, 50.0);
    }
    
    [self.view addSubview:adView];
    [adView release];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [AdMoGoInterstitialManager setAppKey:@""];
    [[AdMoGoInterstitialManager shareInstance] initDefaultInterstitial];
    [AdMoGoInterstitialManager setRootViewController:self];
    [AdMoGoInterstitialManager setDefaultDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}



/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告开始请求回调");
}
/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告接收成功回调");
}
/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    NSLog(@"广告接收失败回调");
}
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    NSLog(@"点击广告回调");
}
/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告关闭回调");
}

#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    NSLog(@"浏览器已经关闭");
}
/**
 *直接下载类广告 是否弹出Alert确认
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
}

#pragma mark -
#pragma mark AdMoGoIntersitial delegate

/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingInterstitialModalView
{
    return self;
}
/*
 全屏广告将要展示
 */
- (void)adsMoGoInterstitialAdWillPresent
{
    
}

/*
 全屏广告消失
 */
- (void)adsMoGoInterstitialAdDidDismiss
{
    
}

/**
 *广告过期
 *是否立即重新轮换广告
 *return YES-->立即轮换 NO-->等待下一次进入展示机会轮换
 */
- (BOOL)adsMogoInterstitialAdDidExpireAd
{
    return NO;
}

/*
 全屏广告浏览器展示
 */
- (void)adsMoGoWillPresentInterstitialAdModal
{
    
}

/*
 全屏广告浏览器消失
 */
- (void)adsMoGoDidDismissInterstitialAdModal
{
    
}

/**
 *芒果全屏 关闭按钮被点击
 *return YES/NO 来确定是否可关闭 default YES
 */
- (BOOL)adsMogoInterstitialAdClosedButtonTap
{
    return YES;
}
/*
 芒果广告关闭
 */
- (void)adsMogoInterstitialAdClosed:(BOOL)isAutoClose
{
    
}


-(BOOL)interstitialShouldAlertQAView:(UIAlertView *)alertView
{
    return NO;
}

-(BOOL)isFullScreen
{
    return YES;
}

/*
 芒果插屏初始化完成
 */
- (void)adMoGoInterstitialInitFinish
{
    
}

/*
 手动轮换下，广告轮空回调
 */
- (void)adMoGoInterstitialInMaualfreshAllAdsFail
{
    
}

@end

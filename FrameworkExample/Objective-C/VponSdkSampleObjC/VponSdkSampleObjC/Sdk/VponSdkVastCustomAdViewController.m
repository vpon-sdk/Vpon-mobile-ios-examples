//
//  VponSdkVastCustomAdViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2018/8/29.
//  Copyright © 2018年 Soul. All rights reserved.
//

#import "VponSdkVastCustomAdViewController.h"

@import VpadnSDKAdKit;

@interface VponSdkVastCustomAdViewController () <VpadnInReadAdDelegate>

@property (nonatomic, weak) IBOutlet UIView *videoLoadedView;

@property (nonatomic, strong) VpadnInReadAd *vpadnInReadAd;

@end

@implementation VponSdkVastCustomAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - VastCustomAd";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestVpadnInReadAd];
}

- (void) requestVpadnInReadAd {
    _vpadnInReadAd = [[VpadnInReadAd alloc] initWithPlacementId:@"" delegate:self];
    [_vpadnInReadAd loadAdWithTestIdentifiers:@[]];
}

#pragma mark - VpadnInReadAd Delegate

- (void) vpadnInReadAdDidLoad:(VpadnInReadAd *)ad {
    NSLog(@"廣告抓取成功");
    UIView *videoView = [ad videoView];
    [_videoLoadedView addSubview:videoView];
    
    videoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_videoLoadedView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[videoView]-0-|" options:0 metrics:nil views:@{@"videoView":videoView}]];
    [_videoLoadedView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[videoView]-0-|" options:0 metrics:nil views:@{@"videoView":videoView}]];
}

- (void) vpadnInReadAd:(VpadnInReadAd *)ad didFailLoading:(NSError *)error {
    NSLog(@"廣告抓取失敗:%@", error.description);
}

- (void)vpadnInReadAdDidStart:(VpadnInReadAd *)ad {
    NSLog(@"影片開始播放");
}

- (void)vpadnInReadAdDidStop:(VpadnInReadAd *)ad {
    NSLog(@"影片播放結束");
}

- (void)vpadnInReadAdDidMute:(VpadnInReadAd *)ad {
    NSLog(@"影片靜音");
}

- (void)vpadnInReadAdDidUnmute:(VpadnInReadAd *)ad {
    NSLog(@"影片取消靜音");
}

- (void)vpadnInReadAdWasClicked:(VpadnInReadAd *)ad {
    NSLog(@"廣告被點擊");
}

- (void)vpadnInReadAdDidTakeOverFullScreen:(VpadnInReadAd *)ad {
    NSLog(@"影片全屏");
}

- (void)vpadnInReadAdDidDismissFullscreen:(VpadnInReadAd *)ad {
    NSLog(@"影片離開全屏");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

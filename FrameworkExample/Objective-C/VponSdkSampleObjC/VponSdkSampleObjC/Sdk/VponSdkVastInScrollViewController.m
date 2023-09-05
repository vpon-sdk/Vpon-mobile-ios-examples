//
//  VponSdkVastInScrollViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2018/8/29.
//  Copyright © 2018年 Soul. All rights reserved.
//

#import "VponSdkVastInScrollViewController.h"

@import VpadnSDKAdKit;

@interface VponSdkVastInScrollViewController () <VpadnInReadAdDelegate>

@property (nonatomic, weak) IBOutlet UIView *inScrollLoadedView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *inScrollHeightConstraint;

@property (nonatomic, weak) IBOutlet UIScrollView *inScrollView;

@property (nonatomic, strong) VpadnInReadAd *vpadnInReadAd;

@end

@implementation VponSdkVastInScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - VastInScroll";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestVpadnInReadAd];
}

- (void) requestVpadnInReadAd {
    _vpadnInReadAd = [[VpadnInReadAd alloc] initWithPlacementId:@"" placeholder:_inScrollLoadedView heightConstraint:_inScrollHeightConstraint scrollView:_inScrollView delegate:self];
    [_vpadnInReadAd loadAdWithTestIdentifiers:@[]];
}

#pragma mark - VpadnInReadAd Delegate

- (void) vpadnInReadAdDidLoad:(VpadnInReadAd *)ad {
    NSLog(@"廣告抓取成功");
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

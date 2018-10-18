//
//  VponSdkVastInTableRepeatViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2018/8/29.
//  Copyright © 2018年 Soul. All rights reserved.
//

#import "VponSdkVastInTableRepeatViewController.h"

@import VpadnSDKAdKit;

@interface VponSdkVastInTableRepeatViewController () <UITableViewDelegate, UITableViewDataSource, VpadnInReadAdDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VpadnInReadAd *vpadnInReadAd;

@end

@implementation VponSdkVastInTableRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SDK - VastInTableRepeat";
    [self requestVpadnInReadAd];
}

- (void) requestVpadnInReadAd {
    _vpadnInReadAd = [[VpadnInReadAd alloc] initWithPlacementId:@"" insertionIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] repeatMode:YES tableView:_tableView delegate:self];
    [_vpadnInReadAd loadAdWithTestIdentifiers:@[]];
}

#pragma mark - UITableView DataSource

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.text = @"Header";
    [view addSubview:label];
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.row == 0 ? @"ContentTabCell" : @"PlaceholderTabCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath %@", indexPath);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

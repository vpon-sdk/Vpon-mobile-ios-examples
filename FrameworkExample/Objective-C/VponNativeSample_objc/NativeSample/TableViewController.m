//
//  TableViewController.m
//  NativeSample
//
//  Created by Mike Chou on 10/24/16.
//  Copyright © 2016 Vpon. All rights reserved.
//

@import VpadnSDKAdKit;
#import "TableViewController.h"
#import "CustomCell.h"

static NSInteger const kRowStrideForAdCell = 3;
static NSString *const kDefaultCellIdentifier = @"normalIdentifier";
static NSString *const kAdCellIdentifier = @"adIdentifier";

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource, VpadnNativeAdsManagerDelegate, VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAdsManager *adsManager;
@property (strong, nonatomic) VpadnNativeAdTableViewAdProvider *ads;

@property (strong, nonatomic) NSMutableArray *tableViewContents;

@end

@implementation TableViewController

#pragma mark - Lazy Loading
- (NSMutableArray *)tableViewContents {
    if (!_tableViewContents) {
        _tableViewContents = [NSMutableArray array];
        for (NSUInteger i = 0; i < 1000; i++) {
            [_tableViewContents addObject:[NSString stringWithFormat:@"TableView Cell #%d", (int)(i+1)]];
        }
    }
    return _tableViewContents;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.adsManager) {
        self.adsManager = [[VpadnNativeAdsManager alloc] initWithBannerID:@"key in your natvie ad id" forNumAdsRequested:5];
        self.adsManager.delegate = self;
    }
    [self.adsManager loadAdsWithTestIdentifiers:@[@"key in your device's idfa"]];
}


#pragma mark - VpadnNativeAdsManagerDelegate

- (void)onVpadnNativeAdsReceived {
    NSLog(@"Ads did loaded");
    
    NSLog(@"Unique count %d", self.adsManager.uniqueNativeAdCount);
    VpadnNativeAdsManager *manager = self.adsManager;
    self.adsManager.delegate = nil;
    self.ads = [[VpadnNativeAdTableViewAdProvider alloc] initWithManager:manager];
    self.ads.delegate = self;
    
    [self.tableView reloadData];
}

- (void)onVpadnNativeAdsFailedToLoadWithError:(NSError *)error {
    NSLog(@"Ads did fail with error %@", error);
}

#pragma mark - VpadnNativeAdDelegate
- (void)onVpadnNativeAdPresent:(VpadnNativeAd *)nativeAd {
    NSLog(@"Native Present %@", nativeAd);
}
- (void)onVpadnNativeAdLeaveApplication:(VpadnNativeAd *)nativeAd {
    NSLog(@"Native Leave Application %@", nativeAd);
}
- (void)onVpadnNativeAdDismiss:(VpadnNativeAd *)nativeAd {
    NSLog(@"Native Dismiss %@", nativeAd);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ads adjustCount:self.tableViewContents.count forStride:kRowStrideForAdCell] ?:self.tableViewContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* Update Native ads manager
    if (indexPath.row != 0 && indexPath.row % 20 == 0) {
        [self.adsManager loadAdsWithTestIdentifiers:@[@"請填入手機的 IDFA"]];
    }
    */
    
    UITableViewCell *cell;
    if ([self.ads isAdCellAtIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kAdCellIdentifier forIndexPath:indexPath];
        VpadnNativeAd *ad = [self.ads tableView:tableView nativeAdForRowAtIndexPath:indexPath];
        [(CustomCell *)cell setNativeAd:ad];
        [ad registerViewForInteraction:cell.contentView withViewController:self];
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
        NSIndexPath *index = [self.ads adjustNonAdCellIndexPath:indexPath forStride:kRowStrideForAdCell]?: indexPath;
        cell.textLabel.text = [self.tableViewContents objectAtIndex:index.row];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

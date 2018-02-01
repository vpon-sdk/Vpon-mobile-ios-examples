//
//  VponSdkNativeTableViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkNativeTableViewController.h"
#import "VponSdkNativeCustomTabCell.h"
#import <AdSupport/AdSupport.h>

#import "VpadnNativeAd.h"
#import "VpadnNativeAdsManager.h"
#import "VpadnNativeAdTableViewAdProvider.h"

static NSInteger const kRowStrideForAdCell = 5;
static NSString *const kDefaultCellIdentifier = @"normalIdentifier";
static NSString *const kAdCellIdentifier = @"adIdentifier";

@interface VponSdkNativeTableViewController () <UITableViewDelegate, UITableViewDataSource, VpadnNativeAdsManagerDelegate, VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAdsManager *adsManager;
@property (strong, nonatomic) VpadnNativeAdTableViewAdProvider *ads;

@property (strong, nonatomic) NSMutableArray *tableViewContents;

@end

@implementation VponSdkNativeTableViewController

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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    
    if (!self.adsManager) {
#warning set ad banner id
        self.adsManager = [[VpadnNativeAdsManager alloc] initWithBannerID:@"" forNumAdsRequested:kRowStrideForAdCell];
        self.adsManager.delegate = self;
        [self.adsManager dontUseWVForNA];
        [self.adsManager showTestLog:NO];
    }
    
    [self.adsManager loadAdsWithTestIdentifiers:@[]];
}


#pragma mark - VpadnNativeAdsManagerDelegate

- (void)onVpadnNativeAdsReceived {
    NSLog(@"Ads did loaded");
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
    UITableViewCell *cell;
    if ([self.ads isAdCellAtIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kAdCellIdentifier forIndexPath:indexPath];
        VpadnNativeAd *ad = [self.ads tableView:tableView nativeAdForRowAtIndexPath:indexPath];
        [(VponSdkNativeCustomTabCell *)cell setNativeAd:ad];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

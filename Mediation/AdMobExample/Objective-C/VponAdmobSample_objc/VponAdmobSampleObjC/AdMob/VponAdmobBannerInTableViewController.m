//
//  VponAdmobBannerInTableViewController.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2018/12/12.
//  Copyright © 2018 Soul. All rights reserved.
//

#import "VponAdmobBannerInTableViewController.h"
#import "AdTableViewCell.h"

@import GoogleMobileAds;

#define ADPOS 5
#define DATANUM 10

#define TITLE @"title"

@interface VponAdmobBannerInTableViewController () <GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) GADBannerView *gadBannerView;

@property (nonatomic, weak) IBOutlet UITableView *mainTable;

@end

@implementation VponAdmobBannerInTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AdMob - BannerInTable";
    
    _datas = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < DATANUM; index++) {
        [_datas addObject:@{TITLE: [NSString stringWithFormat:@"Data %ld", (long)index]}];
    }
    
    [self requestButtonDidTouch:nil];
}

#pragma mark - Button Method

- (IBAction) requestButtonDidTouch:(UIButton *)sender {
    if (_gadBannerView.superview) {
        [_gadBannerView removeFromSuperview];
    }
    
    GADRequest *request = [GADRequest request];
//    GADExtras *extra = [[GADExtras alloc] init];
//    extra.additionalParameters = @{
//        @"contentURL": @"https://www.vpon.com",
//        @"contentData": @{@"key1": @"Admob", @"key2": @(1.2), @"key3": @(YES)},
//        @"friendlyObstructions": @[@{ @"view": [[UIView alloc] init], @"purpose": @(2), @"desc": @"not_visible"}]
//    };
//    [request registerAdNetworkExtras:extra];
//    request.testDevices = @[kGADSimulatorID];
    
    _gadBannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeMediumRectangle];
    _gadBannerView.adUnitID = @"";
    _gadBannerView.delegate = self;
    _gadBannerView.rootViewController = self;
    [_gadBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView {
    NSLog(@"Received banner ad successfully");
    [_mainTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:ADPOS inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)bannerView:(nonnull GADBannerView *)bannerView didFailToReceiveAdWithError:(nonnull NSError *)error {
    NSLog(@"Failed to receive banner with error: %@", [error localizedFailureReason]);
    [_mainTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:ADPOS inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ADPOS) {
        AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdTableViewCell" forIndexPath:indexPath];
        if (_gadBannerView) {
            [cell.contentView addSubview:_gadBannerView];
            _gadBannerView.center = cell.contentView.center;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
        NSIndexPath *current = [self currentIndexPath:indexPath];
        NSDictionary *data = [_datas objectAtIndex:current.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", data[TITLE]];
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ADPOS) {
        return 250;
    } else {
        return 44;
    }
}

- (NSIndexPath *) currentIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < ADPOS) {
        return indexPath;
    } else {
        return [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
    }
}

@end

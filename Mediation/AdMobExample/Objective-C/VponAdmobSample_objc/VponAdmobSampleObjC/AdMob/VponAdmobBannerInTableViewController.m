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

@property (strong, nonatomic) GADBannerView *gadBannerView;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@property (nonatomic, weak) IBOutlet UITableView *mainTable;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation VponAdmobBannerInTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < DATANUM; index++) {
        [_datas addObject:@{TITLE: [NSString stringWithFormat:@"Data %ld", (long)index]}];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestButtonDidTouch:nil];
}

#pragma mark - Button Method

- (void) requestButtonDidTouch:(UIButton *)sender {
    if (self.gadBannerView != nil) {
        [self.gadBannerView removeFromSuperview];
    }
    
    GADRequest *request = [GADRequest request];
//    GADExtras *extra = [[GADExtras alloc] init];
//    extra.additionalParameters = @{
//        @"contentURL": @"https://www.vpon.com",
//        @"contentData": @{@"key1": @"Admob", @"key2": @(1.2), @"key3": @(YES)}
//    };
//    [request registerAdNetworkExtras:extra];
//    request.testDevices = @[kGADSimulatorID];
            
    
    self.gadBannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(_loadBannerView.frame.size)];
    self.gadBannerView.adUnitID = @"ca-app-pub-7987617251221645/3532457573";
    self.gadBannerView.delegate = self;
    self.gadBannerView.rootViewController = self;
    [self.gadBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [self.loadBannerView addSubview:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    
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
        cell.rootViewController = self;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
        NSIndexPath *current = [self currentIndexPath:indexPath];
        NSDictionary *data = [_datas objectAtIndex:current.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", data[TITLE]];
        return cell;
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

//
//  VponDFPBannerInTableViewController.m
//  VponDFPSampleObjC
//
//  Created by Yi-Hsiang, Chien on 2020/9/25.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "VponDFPBannerInTableViewController.h"
#import "AdTableViewCell.h"

@import GoogleMobileAds;

#define ADPOS 5
#define DATANUM 10

#define TITLE @"title"

@interface VponDFPBannerInTableViewController () <GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (strong, nonatomic) DFPBannerView *dfpBannerView;

@property (nonatomic, weak) IBOutlet UITableView *mainTable;

@end

@implementation VponDFPBannerInTableViewController

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
    if (_dfpBannerView != nil) {
        [_dfpBannerView removeFromSuperview];
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
    
    _dfpBannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeMediumRectangle];
    _dfpBannerView.adUnitID = @"";
    _dfpBannerView.delegate = self;
    _dfpBannerView.rootViewController = self;
    [_dfpBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"Received banner ad successfully");
    [_mainTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:ADPOS inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
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
        if (_dfpBannerView) {
            [cell.contentView addSubview:_dfpBannerView];
            _dfpBannerView.center = cell.contentView.center;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

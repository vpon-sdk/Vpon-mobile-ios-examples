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

@import VpadnSDKAdKit;

static NSInteger const kRequestNumber = 5;
static NSInteger const kRowStrideForAdCell = 10;
static NSString *const kDefaultCellIdentifier = @"normalIdentifier";
static NSString *const kAdCellIdentifier = @"adIdentifier";

@interface VponSdkNativeTableViewController () <UITableViewDelegate, UITableViewDataSource, VpadnNativeAdsManagerDelegate, VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAdsManager *adsManager;
@property (strong, nonatomic) VpadnNativeAdTableViewAdProvider *adsProvider;

@property (strong, nonatomic) NSMutableArray *tableViewContents;

@end

@implementation VponSdkNativeTableViewController

#pragma mark - Lazy Loading
- (void)addContents {
    if (!_tableViewContents) {
        _tableViewContents = [NSMutableArray array];
        for (NSUInteger i = 0; i < 1000; i++) {
            [_tableViewContents addObject:[NSString stringWithFormat:@"TableView Cell #%d", (int)(i+1)]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - NativeInTable";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    
    [self addContents];
    [self request];
}

#pragma mark - Initial VpadnAdRequest

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    [request setTestDevices:@[[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString]];   //取得測試廣告
    [request setUserInfoGender:VpadnGenderMale];                                                        //性別
    [request setUserInfoBirthdayWithYear:2000 Month:8 andDay:17];                                       //生日
    [request setMaxAdContentRating:VpadnMaxAdContentRatingGeneral];                                     //最高可投放的年齡(分類)限制
    [request setTagForUnderAgeOfConsent:VpadnTagForUnderAgeOfConsentFalse];                             //是否專為特定年齡投放
    [request setTagForChildDirectedTreatment:VpadnTagForChildDirectedTreatmentFalse];                   //是否專為兒童投放
    [request addKeyword:@"keywordA"];                                                                   //關鍵字
    [request addKeyword:@"key1:value1"];                                                                //鍵值
    return request;
}

- (void) request {
    if (!_adsManager) {
        _adsManager = [[VpadnNativeAdsManager alloc] initWithLicenseKey:@"8a80854b6a90b5bc016ad81ac68c6530" forNumAdsRequested:kRequestNumber];
        _adsManager.delegate = self;
        _adsProvider = [[VpadnNativeAdTableViewAdProvider alloc] initWithManager:_adsManager];
        _adsProvider.delegate = self;
    }
    [_adsManager loadRequest:[self initialRequest]];
}

#pragma mark - VpadnNativeAdsManager Delegate

- (void) onVpadnNativeAdsLoaded:(VpadnNativeAdsManager *)adsManager {
    [self.tableView reloadData];
}

- (void) onVpadnNativeAds:(VpadnNativeAdsManager *)adsManager failedToLoad:(NSError *)error {
    
}

#pragma mark - VpadnNativeAd Delegate

- (void) onVpadnNativeAdWillLeaveApplication:(VpadnNativeAd *)nativeAd {
    
}

- (void) onVpadnNativeAdClicked:(VpadnNativeAd *)nativeAd {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_adsProvider adjustCount:_tableViewContents.count forStride:kRowStrideForAdCell] ?:_tableViewContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if ([_adsProvider isAdCellAtIndexPath:indexPath forStride:kRowStrideForAdCell]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kAdCellIdentifier forIndexPath:indexPath];
        VpadnNativeAd *ad = [_adsProvider tableView:tableView nativeAdForRowAtIndexPath:indexPath];
        [(VponSdkNativeCustomTabCell *)cell setNativeAd:ad];
        [ad registerViewForInteraction:cell.contentView withViewController:self];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
        NSIndexPath *index = [_adsProvider adjustNonAdCellIndexPath:indexPath forStride:kRowStrideForAdCell]?: indexPath;
        cell.textLabel.text = [_tableViewContents objectAtIndex:index.row];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

//
//  VponMenuTableViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/7/18.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponMenuTableViewController.h"

#import "VponSdkVastInTableRepeatViewController.h"
#import "VponSdkVastInTableViewController.h"

@interface VponMenuTableViewController ()

@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) NSArray *sortKeys;

@end

@implementation VponMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    
    _data = [[NSDictionary alloc] initWithObjectsAndKeys:
                 @"goVponSdkBannerViewController", @"SDK - Banner",
                 @"goVponSdkInterstitialViewController", @"SDK - Interstitial",
                 @"goVponSdkNativeViewController", @"SDK - Native",
                 @"goVponSdkVastCustomAdViewController", @"SDK - VastCustomAd",
                 @"goVponSdkVastInScrollViewController", @"SDK - VastInScroll",
                 @"goVponSdkVastInTableViewController", @"SDK - VastInTable",
                 @"goVponSdkVastInTableRepeatViewController", @"SDK - VastInTableRepeat",  nil];
    
    _sortKeys = [_data.allKeys sortedArrayUsingDescriptors:@[
        [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]
    ]];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [_sortKeys objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [_sortKeys objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:[_data objectForKey:key] sender:nil];
}

@end

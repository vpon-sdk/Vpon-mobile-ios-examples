//
//  VponMenuTableViewController.m
//  VponDFPSampleObjC
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponMenuTableViewController.h"

@interface VponMenuTableViewController ()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation VponMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSDictionary alloc] initWithObjectsAndKeys: @"goVponAdmobBannerViewController", @"AdMob - Banner", @"goVponAdmobInterstitialViewController", @"AdMob - Interstitial", @"goVponAdmobNativeViewController", @"AdMob - Native",  nil];
    self.title = @"Menu";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    NSArray *titles = self.data.allKeys;
    cell.textLabel.text = [titles objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *identifiers = self.data.allValues;
    [self performSegueWithIdentifier:[identifiers objectAtIndex:indexPath.row] sender:nil];
}

@end

//
//  VponSdkSplashViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2017/11/29.
//  Copyright © 2017年 Soul. All rights reserved.
//

#import "VponSdkSplashViewController.h"

#import <AdSupport/AdSupport.h>

@import VpadnSDKAdKit;

@interface VponSdkSplashViewController () <VpadnSplashDelegate>

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (strong, nonatomic) VpadnSplash *vpadnSplash;

@end

@implementation VponSdkSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.vpadnSplash = [[VpadnSplash alloc] initWithSplashId:@"" withTarget:self.splashView];
    self.vpadnSplash.delegate = self;
    [self.vpadnSplash setTestMode:YES];
    [self.vpadnSplash setEndurableSecond:3];
    
    [self.vpadnSplash loadSplashWithTestIdentifiers:@[[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]]];
}

- (void)backToMainPage {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainViewController;
}

/// VpadnSplash Delegate

- (void)onVpadnSplashReceived:(nonnull VpadnSplash *)vpadnSplash {
    NSLog(@"onVpadnSplashReceived");
}

- (void)onVpadnSplash:(nonnull VpadnSplash *)vpadnSplash didFailToReceiveAdWithError:(nullable NSError *)error {
    NSLog(@"onVpadnSplash:didFailToReceiveAdWithError");
    [self backToMainPage];
}

- (void)onVpadnSplashClicked:(nonnull VpadnSplash *)vpadnSplash {
    NSLog(@"onVpadnSplashClicked");
    
}

- (void)onVpadnSplashLeaveApplication:(nonnull VpadnSplash *)vpadnSplash {
    NSLog(@"onVpadnSplashLeaveApplication");
    
}

- (void)onVpadnSplashAllowToDismiss:(nonnull VpadnSplash *)vpadnSplash {
    NSLog(@"onVpadnSplashDismiss");
    [self backToMainPage];
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

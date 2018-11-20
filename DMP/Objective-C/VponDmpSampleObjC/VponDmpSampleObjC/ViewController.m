//
//  ViewController.m
//  VponDmpSampleObjC
//
//  Created by EricChien on 2018/11/20.
//  Copyright © 2018 Vpon. All rights reserved.
//

#import "ViewController.h"
#import "sdk_vpadn/VpadnAnalytics.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[VpadnAnalytics sharedInstance].defaultTracker send:[[VpadnDictionaryBuilder
                                                           createEventWithEventType:Event_Custom
                                                           customID:@"tettetete"
                                                           extraData:nil]
                                                          build]];
}

- (IBAction) sendLaunch:(id)sender
{
    [[VpadnAnalytics sharedInstance].defaultTracker sendLaunchEvent:nil];
}

- (IBAction) sendEvent:(id)sender
{
    NSMutableDictionary* dicData = [[NSMutableDictionary alloc]initWithCapacity:1];
    
    // Number
    [dicData setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] ] forKey:@"timestamp"];
    
    // String
    [dicData setObject:@"$23AbcAB:" forKey:@"VpadnKey1"];
    
    // URL
    [dicData setObject:@"http://www.abc.com/?A=Testing&B=23AbcAB" forKey:@"VpadnKey2"];
    
    // Object
    NSDictionary* dicTest2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"&='^|\[]=&", @"DataKey1",
                              @"http://www.def.com/?A=字元!@#$%^*()_=", @"DataKey2", nil];
    NSDictionary* dicTest = [[NSDictionary alloc] initWithObjectsAndKeys: dicTest2, @"1235", nil];
    [dicData setObject:dicTest forKey:@"VpadnKey3"];
    
    int iRandom = arc4random_uniform(10);
    [[VpadnAnalytics sharedInstance].defaultTracker send:[[VpadnDictionaryBuilder
                                                           createEventWithEventType:iRandom
                                                           customID:nil
                                                           extraData:dicData]
                                                          build]];
}


@end

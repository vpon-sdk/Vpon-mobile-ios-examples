//
//  AppDelegate.m
//  VponDmpSampleObjC
//
//  Created by EricChien on 2018/11/20.
//  Copyright © 2018 Vpon. All rights reserved.
//

#import "AppDelegate.h"
#import "sdk_vpadn/VpadnAnalytics.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifySendRequest:) name:@"sendRequest" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyGetResponse:) name:@"getResponse" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyUpdateSessionID:) name:@"updateSession" object:nil];
    

    VpadnAnalytics *analytics = [VpadnAnalytics sharedInstance];
    id<VATracker> traker = analytics.defaultTracker;
    
    [analytics setLicenseKey:@"licenseKey"];
    [traker sendLaunchEvent:nil];
    
    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_Login customID:@"" extraData:nil] build]];
    
    
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_AddToCart customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_Category customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_Checkout customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_Custom customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_EelementInteract customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_Item customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_PageView customID:@"" extraData:nil] build]];
//    [traker send:[[VpadnDictionaryBuilder createEventWithEventType:Event_None customID:@"" extraData:nil] build]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - notify

- (void)notifySendRequest:(NSNotification*)notification
{
    NSDictionary* dictionary = [notification userInfo];
    NSLog(@"request string %@", [dictionary objectForKey:@"requestString"]);
    NSLog(@"\nafter decode %@", [[dictionary objectForKey:@"requestString"] stringByRemovingPercentEncoding]);
}

- (void)notifyGetResponse:(NSNotification*)notification
{
    NSDictionary* dictionary = [notification userInfo];
    NSLog(@"response code %@", [dictionary objectForKey:@"responseCode"]);
}

- (void)notifyUpdateSessionID:(NSNotification*)notification
{
    NSDictionary* dictionary = [notification userInfo];
    NSLog(@"new sessionID is %@", [dictionary objectForKey:@"sessionID"]);
}

@end

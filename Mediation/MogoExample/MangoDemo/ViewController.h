//
//  ViewController.h
//  MangoDemo
//
//  Created by Chenchung Wu on 2014/12/9.
//  Copyright (c) 2014年 Chenchung Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "AdMoGoInterstitial.h"
#import "AdMoGoInterstitialManager.h"
#import "AdMoGoInterstitialDelegate.h"

@interface ViewController : UIViewController<AdMoGoDelegate, AdMoGoWebBrowserControllerUserDelegate,AdMoGoInterstitialDelegate>

{
    AdMoGoView *adView;
}
@property (nonatomic, retain) AdMoGoView *adView;

@end


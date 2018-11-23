//
//  VponAdmobNativeViewController.h
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2018/10/25.
//  Copyright © 2018 Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VponAdmobNativeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

/// Container that holds the native ad.
@property(nonatomic, weak) IBOutlet UIView *nativeAdPlaceholder;

/// Indicates if video ads should start muted.
@property(nonatomic, weak) IBOutlet UISwitch *startMutedSwitch;

/// Displays status messages about video assets.
@property(nonatomic, weak) IBOutlet UILabel *videoStatusLabel;

/// The Google Mobile Ads SDK version number label.
@property(nonatomic, weak) IBOutlet UILabel *versionLabel;

@end

NS_ASSUME_NONNULL_END

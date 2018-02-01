//
//  VpadnMediaView.h
//  vpon-sdk
//
//  Created by EricChien on 2018/1/4.
//  Copyright © 2018年 com.vpon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VpadnMediaViewDelegate;
@class VpadnNativeAd;

@interface VpadnMediaView : UIView

/**
 the delegate
 */
@property (nonatomic, weak, nullable) id<VpadnMediaViewDelegate> delegate;

/**
 This is a method to create a media view using the given native ad.
 - Parameter nativeAd: The native ad to load media content from.
 */
- (instancetype)initWithNativeAd:(VpadnNativeAd *)nativeAd;

/**
 the native ad, can be set again to reuse this view.
 */
@property (nonatomic, strong, nonnull) VpadnNativeAd *nativeAd;


@end

/**
 The methods declared by the VpadnMediaViewDelegate protocol allow the adopting delegate to respond to messages from the VpadnMediaView class and thus respond to operations such as whether the media content has been loaded.
 */
@protocol VpadnMediaViewDelegate <NSObject>

@optional

/**
 Sent when an VpadnMediaView has been successfully loaded.
 
 - Parameter mediaView: An VpadnMediaView object sending the message.
 */
- (void)mediaViewDidLoad:(VpadnMediaView *)mediaView;

@end

NS_ASSUME_NONNULL_END

//
//  VpadnAdRequest+Internal.h
//  vpon-sdk
//
//  Created by EricChien on 2019/9/16.
//  Copyright © 2019 com.vpon. All rights reserved.
//
#import "VpadnAdRequest.h"

@class VpadnAdBaseViewController;

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdRequest (Internal)

/// Publisher傳入的位置
@property (nonatomic, strong, nullable) CLLocation *userLocation;

/// 自動更新
@property (nonatomic, assign) BOOL autoRefresh;

/// 是否取測試廣告
@property (nonatomic, copy) NSString *adtest;

/// 設置ContentURL
@property (nonatomic, copy) NSString *contentURL;

/// 設置ContentData
@property (nonatomic, strong) NSMutableDictionary *contentDic;

/// 是否有關鍵字群
@property (nonatomic, assign) BOOL haveKeyword;

/// 關鍵字群
@property (nonatomic, strong) NSMutableArray *keywords;

/// 是否有額外的資訊
@property (nonatomic, assign) BOOL haveExtraData;

/// 額外資訊
@property (nonatomic, strong) NSMutableDictionary *extraData;

/// 最高可投放的年齡(分類)限制
@property (nonatomic, assign) VpadnMaxAdContentRating maxAdContentRating;

/// 是否專為特定年齡投放
@property (nonatomic, assign) VpadnTagForUnderAgeOfConsent underAgeOfConsent;

/// 是否專為兒童投放
@property (nonatomic, assign) VpadnTagForChildDirectedTreatment childDirectedTreatment;

/// 排除遮蔽偵測的視圖們
@property (nonatomic, strong) NSMutableArray *friendlyObstructions;

///
@property (nonatomic, weak) VpadnAdBaseViewController *baseVC;

#pragma mark - UITest

- (void) sendRecordToRemote:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END

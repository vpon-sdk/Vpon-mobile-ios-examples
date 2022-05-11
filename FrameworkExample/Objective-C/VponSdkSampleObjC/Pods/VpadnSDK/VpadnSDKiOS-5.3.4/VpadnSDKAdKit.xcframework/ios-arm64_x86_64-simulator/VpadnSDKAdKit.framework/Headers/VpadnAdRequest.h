//
//  VpadnAdRequest.h
//  vpon-sdk
//
//  Created by EricChien on 2019/9/12.
//  Copyright © 2019 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VpadnFriendlyObstructionType) {
    VpadnFriendlyObstructionMediaControls = 0,
    VpadnFriendlyObstructionCloseAd,
    VpadnFriendlyObstructionNotVisible,
    VpadnFriendlyObstructionOther
};

typedef NS_ENUM(NSInteger, VpadnUserGender) {
    VpadnGenderUnspecified = -1,
    VpadnGenderMale,
    VpadnGenderFemale,
    VpadnGenderUnKnown
};

typedef NS_ENUM(NSInteger, VpadnMaxAdContentRating) {
    VpadnMaxAdContentRatingUnspecified = -1,
    VpadnMaxAdContentRatingGeneral = 0,
    VpadnMaxAdContentRatingParentalGuidance = 1,
    VpadnMaxAdContentRatingTeen = 2,
    VpadnMaxAdContentRatingMatureAudience = 3,
};

typedef NS_ENUM(NSInteger, VpadnTagForChildDirectedTreatment) {
    VpadnTagForChildDirectedTreatmentUnspecified = -1,
    VpadnTagForChildDirectedTreatmentFalse = 0,
    VpadnTagForChildDirectedTreatmentTrue = 1,
};

typedef NS_ENUM(NSInteger, VpadnTagForUnderAgeOfConsent) {
    VpadnTagForUnderAgeOfConsentUnspecified = -1,
    VpadnTagForUnderAgeOfConsentFalse = 0,
    VpadnTagForUnderAgeOfConsentTrue = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface VpadnAdRequest : NSObject

/// 取得當前版號
+ (NSString *)sdkVersion;

#pragma mark - 廣告內容相關

/// 設定測試的裝置
/// @param testDevices 裝置的IDFA
- (void) setTestDevices:(NSArray *)testDevices;

/// 是否能夠自動播放
- (void) setAutoRefresh:(BOOL)autoRefresh;

/// 最高可投放的年齡(分類)限制
- (void) setMaxAdContentRating:(VpadnMaxAdContentRating)rating;

/// 是否專為特定年齡投放
- (void) setTagForUnderAgeOfConsent:(VpadnTagForUnderAgeOfConsent)underAgeOfConsent;

/// 是否專為兒童投放
- (void) setTagForChildDirectedTreatment:(VpadnTagForChildDirectedTreatment)childDirectedTreatment;

/// 設置ContentURL
/// @param contentURL 內容網址
- (void) setContentUrl:(NSString *)contentURL;

/// 設置ContentData
/// @param contentData 內容
- (void) setContentData:(NSDictionary *)contentData;

/// 新增ContentData
/// @param key 鍵
/// @param value 值
- (void) addContentDataWithKey:(NSString *)key value:(NSString *)value;

#pragma mark - 使用者相關

/// 設定定位位置
- (void) setUserInfoLocation:(CLLocation *)location;

/// 設定使用者年齡
- (void) setUserInfoAge:(NSInteger)age;

/// 設定使用者生日
- (void) setUserInfoBirthdayWithYear:(NSInteger)year
                               Month:(NSInteger)month
                              andDay:(NSInteger)day;

/// 設定使用者性別
- (void) setUserInfoGender:(VpadnUserGender)gender;

#pragma mark - Friendly Obstruction

/// 排除遮蔽偵測的視圖
- (void) addFriendlyObstruction:(UIView *)obstructView purpose:(VpadnFriendlyObstructionType)purpose description:(NSString *)description;

#pragma mark - 關鍵字

/// 設定關鍵字
/// 可以使用Key:Value的方式 addKeyword(@"Keyword1:Value1"), 同時也可以直接關鍵字直接加入 addKeyword(@"Keyword")
/// @param keyword  關鍵字 / 鍵值
- (void) addKeyword:(NSString*)keyword;


@end

NS_ASSUME_NONNULL_END

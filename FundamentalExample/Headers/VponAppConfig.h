/**
 * @note Copyright (C) 2012~, Vpon Incorporated. All Rights Reserved.
 *       This program is an unpublished copyrighted work which is proprietary to
 *       Vpon Incorporated and contains confidential information that is
 *       not to be reproduced or disclosed to any other person or entity without
 *       prior written consent from Vpon, Inc. in each and every instance.
 *
 * @warning Unauthorized reproduction of this program as well as unauthorized
 *          preparation of derivative works based upon the program or distribution of
 *          copies by sale, rental, lease or lending are violations of federal
 *          copyright laws and state trade secret laws, punishable by civil and
 *          criminal penalties.
 *
 * @file    VponAppConfig.h
 *
 * @brief   support publisher to use Vpadn ad
 *
 * @author  Alan(alan.tseng@vpon.com)
 *
 *
 * @date    2017/9/26
 *
 * @version 4.6.7
 *
 * @remark
 *
 **/

#pragma mark SDK 基本通用設定.

#import <Foundation/Foundation.h>

typedef enum {
    VpadnLogLevelOfDebug = 0,
    VpadnLogLevelOfDefault,
    VpadnLogLevelOfWarning,
    VpadnLogLevelOfOnlyError,
} VpadnLogLevel;

@interface VponAppConfig : NSObject

+ (void) setVponLogLevel:(VpadnLogLevel)vpadnLogLevel;


@end

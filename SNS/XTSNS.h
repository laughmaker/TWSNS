//
//  XTSNS.h
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTShare.h"
#import "XTShareView.h"
#import "XTOAuth.h"
#import "OpenShareHeader.h"
#import "OpenShare.h"

static NSString *const kSNSPlatformWeixinKey = @"sns_weixin";
static NSString *const kSNSPlatformWeiboKey = @"sns_weixin";
static NSString *const kSNSPlatformQQKey = @"sns_qq";

@interface XTSNS : NSObject

/**
 *  注册各个平台的Appid
 *
 *  @param appIds Key为头文件顶部定义的字符串
 */
+ (void)registerAppIds:(NSDictionary *)appIds;

@end

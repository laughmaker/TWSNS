//
//  XTSNS.m
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "XTSNS.h"

@implementation XTSNS

+ (void)registerAppIds:(NSDictionary *)appIds
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (appIds[kSNSPlatformQQKey]) {
            [OpenShare connectQQWithAppId:appIds[kSNSPlatformQQKey]];
        }
        if (appIds[kSNSPlatformWeiboKey]) {
            [OpenShare connectWeiboWithAppKey:appIds[kSNSPlatformWeiboKey]];
        }
        if (appIds[kSNSPlatformWeixinKey]) {
            [OpenShare connectWeixinWithAppId:appIds[kSNSPlatformWeixinKey]];
        }
    });
}

@end

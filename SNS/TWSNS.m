//
//  XTSNS.m
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "TWSNS.h"

@implementation TWSNS

+ (void)registerWeiboAppId:(NSString *)appId secret:(NSString *)secret redirectURI:(NSString *)redirectURI
{
    [OpenShare connectWeiboWithAppKey:appId];
    
    [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatformWeiboIdKey];
    [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatformWeiboSecretKey];
    [[NSUserDefaults standardUserDefaults] setObject:redirectURI forKey:kSNSPlatformWeiboRedirectURIKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)registerQQAppId:(NSString *)appId secret:(NSString *)secret
{
    [OpenShare connectQQWithAppId:appId];
    
    [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatformQQIdKey];
    [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatformQQSecretKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)registerWeiXinAppId:(NSString *)appId secret:(NSString *)secret
{
    [OpenShare connectWeixinWithAppId:appId];
    
    [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatformWeixinIdKey];
    [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatformWeixinSecretKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

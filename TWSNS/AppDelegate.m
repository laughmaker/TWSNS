//
//  AppDelegate.m
//  XTSNS
//
//  Created by 何振东 on 15/9/8.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "AppDelegate.h"
#import "TWSNS.h"

///微信第三方登录(传情)
static NSString *const kWeiXinAppId         = @"wxd41b2ec423a3ea58";
static NSString *const kWeiXinAppSecret     = @"bd40be2331162a1b32eb1abb5da9f0b3";
static NSString *const kWeiXinRefreshToken  = @"ChuanQingWeiXinRefreshToken";

///微博第三方登录(传情)
static NSString *const kWeiBoAppId          = @"1066360212";
static NSString *const kWeiBoAppSecret      = @"09a4a3d98b5c5db09e03346337fa4bcf";
static NSString *const kWeiBoAppRedirectURL = @"http://sns.whalecloud.com/sina2/callback";

///QQ第三方登录(传情)
static NSString *const kQQAppId          = @"1104505542";
static NSString *const kQQAppSecret      = @"FSluzJHctKTy0NmQ";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TWSNS registerQQAppId:kQQAppId secret:kQQAppSecret];
    [TWSNS registerWeiboAppId:kWeiBoAppId secret:kWeiBoAppSecret redirectURI:kWeiBoAppRedirectURL];
    [TWSNS registerWeiXinAppId:kWeiXinAppId secret:kWeiXinAppSecret];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    
    return YES;

}

@end

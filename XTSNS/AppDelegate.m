//
//  AppDelegate.m
//  XTSNS
//
//  Created by 何振东 on 15/9/8.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "AppDelegate.h"
#import "OpenShare.h"
#import "OpenShareHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [OpenShare connectQQWithAppId:@"1103194207"];
    [OpenShare connectWeiboWithAppKey:@"402180334"];
    [OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"];
    [OpenShare connectRenrenWithAppId:@"228525" AndAppKey:@"1dd8cba4215d4d4ab96a49d3058c1d7f"];
    [OpenShare connectAlipay];//支付宝参数都是服务器端生成的，这里不需要key.

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

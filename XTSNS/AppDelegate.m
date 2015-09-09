//
//  AppDelegate.m
//  XTSNS
//
//  Created by 何振东 on 15/9/8.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "AppDelegate.h"
#import "XTSNS.h"
#import "OpenShareHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *appIds = @{kSNSPlatformQQKey: @"1103194207",
                             kSNSPlatformWeiboKey: @"402180334",
                             kSNSPlatformWeixinKey: @"wxd930ea5d5a258f4f"};
    [XTSNS registerAppIds:appIds];
    
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

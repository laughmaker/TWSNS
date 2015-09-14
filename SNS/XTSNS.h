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

static NSString *const kSNSPlatformWeixinIdKey         = @"kSNSPlatformWeixinIdKey";
static NSString *const kSNSPlatformWeiboIdKey          = @"kSNSPlatformWeiboIdKey";
static NSString *const kSNSPlatformQQIdKey             = @"kSNSPlatformQQIdKey";
static NSString *const kSNSPlatformWeixinSecretKey     = @"kSNSPlatformWeixinSecretKey";
static NSString *const kSNSPlatformWeiboSecretKey      = @"kSNSPlatformWeiboSecretKey";
static NSString *const kSNSPlatformWeiboRedirectURIKey = @"kSNSPlatformWeiboRedirectURIKey";
static NSString *const kSNSPlatformQQSecretKey         = @"kSNSPlatformQQSecretKey";

@interface XTSNS : NSObject

+ (void)registerWeiboAppId:(NSString *)appId secret:(NSString *)secret redirectURI:(NSString *)redirectURI;
+ (void)registerQQAppId:(NSString *)appId secret:(NSString *)secret;
+ (void)registerWeiXinAppId:(NSString *)appId secret:(NSString *)secret;

@end

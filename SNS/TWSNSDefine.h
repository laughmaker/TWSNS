//
//  XTSNSDefine.h
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义社交平台类型
typedef enum : NSUInteger {
    TWSNSPlatformWeiXin = 1,
    TWSNSPlatformQQ,
    TWSNSPlatformWeibo,
} TWSNSPlatform;


// 定义分享类型
typedef enum : NSUInteger {
    TWSNSShareTypeWXSceneSession = 1,  // 分享到微信会话
    TWSNSShareTypeWXSceneTimeline,     // 分享到微信朋友圈
    TWSNSShareTypeQQ,                  // 分享到QQ好友
    TWSNSShareTypeQQZone,              // 分享到QQ空间
    TWSNSShareTypeWeibo,               // 分享到新浪微博
} TWSNSShareType;


// 定义相关常量定义Key
static NSString *const kSNSPlatformWeixinIdKey         = @"kSNSPlatformWeixinIdKey";
static NSString *const kSNSPlatformWeiboIdKey          = @"kSNSPlatformWeiboIdKey";
static NSString *const kSNSPlatformQQIdKey             = @"kSNSPlatformQQIdKey";
static NSString *const kSNSPlatformWeixinSecretKey     = @"kSNSPlatformWeixinSecretKey";
static NSString *const kSNSPlatformWeiboSecretKey      = @"kSNSPlatformWeiboSecretKey";
static NSString *const kSNSPlatformWeiboRedirectURIKey = @"kSNSPlatformWeiboRedirectURIKey";
static NSString *const kSNSPlatformQQSecretKey         = @"kSNSPlatformQQSecretKey";

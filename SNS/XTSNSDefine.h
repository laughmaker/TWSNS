//
//  XTSNSDefine.h
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义分类平台类型
typedef enum : NSUInteger {
    XTSNSPlatformWXSceneSession = 1,  // 分享到微信会话
    XTSNSPlatformWXSceneTimeline,     // 分享到微信朋友圈
    XTSNSPlatformQQ,                  // 分享到QQ好友
    XTSNSPlatformQQZone,              // 分享到QQ空间
    XTSNSPlatformWeibo,               // 分享到新浪微博
} XTSNSPlatform;

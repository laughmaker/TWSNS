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
    XTSNSPlatformWeiXin = 1,
    XTSNSPlatformQQ,
    XTSNSPlatformWeibo,
} XTSNSPlatform;


// 定义分享类型
typedef enum : NSUInteger {
    XTSNSShareTypeWXSceneSession = 1,  // 分享到微信会话
    XTSNSShareTypeWXSceneTimeline,     // 分享到微信朋友圈
    XTSNSShareTypeQQ,                  // 分享到QQ好友
    XTSNSShareTypeQQZone,              // 分享到QQ空间
    XTSNSShareTypeWeibo,               // 分享到新浪微博
} XTSNSShareType;


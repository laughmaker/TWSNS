//
//  XTShare.h
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpenShareHeader.h"
#import "OpenShare.h"

/**
 *  分享控制类
 */
// 定义分类平台类型
typedef enum : NSUInteger {
    XTSharePlatformWXSceneSession = 1,  // 分享到微信会话
    XTSharePlatformWXSceneTimeline,     // 分享到微信朋友圈
    XTSharePlatformQQ,                  // 分享到QQ好友
    XTSharePlatformQQZone,              // 分享到QQ空间
    XTSharePlatformWeibo,               // 分享到新浪微博
} XTSharePlatform;

@interface XTShare : NSObject

/**
 *  分享消息的内容到相应平台
 *
 *  @param message  分享消息
 *  @param platform 分享平台
 */
+ (void)shareMessage:(OSMessage *)message toPlatform:(XTSharePlatform)platform;


/**
 *  发送文本消息消息
 *
 *  @param text     文本消息内容
 *  @param platform 所发送的平台
 */
+ (void)shareText:(NSString *)text toPlatform:(XTSharePlatform)platform;

/**
 *  发送文本消息消息
 *
 *  @param text     文本消息内容
 *  @param image    要分享的图片
 *  @param platform 所发送的平台
 */
+ (void)shareText:(NSString *)text image:(UIImage *)image toPlatform:(XTSharePlatform)platform;

/**
 *  分享链接信息
 *
 *  @param linkUrl     链接地址
 *  @param thumb       要显示的缩略图
 *  @param title       要分享的链接的标题
 *  @param description 要分享的链接描述
 *  @param platform    需要分享的平台
 */
+ (void)shareLink:(NSString *)linkUrl image:(UIImage *)image title:(NSString *)title description:(NSString *)description toPlatform:(XTSharePlatform)platform;

@end

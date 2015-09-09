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
#import "XTSNSDefine.h"

/**
 *  分享控制类
 */
@interface XTShare : NSObject

/**
 *  分享消息的内容到相应平台
 *
 *  @param message  分享消息
 *  @param platform 分享平台
 */
+ (void)shareMessage:(OSMessage *)message toPlatform:(XTSNSPlatform)platform;


/**
 *  发送文本消息消息
 *
 *  @param text     文本消息内容
 *  @param platform 所发送的平台
 */
+ (void)shareText:(NSString *)text toPlatform:(XTSNSPlatform)platform;

/**
 *  发送文本消息消息
 *
 *  @param text     文本消息内容
 *  @param image    要分享的图片
 *  @param platform 所发送的平台
 */
+ (void)shareText:(NSString *)text image:(UIImage *)image toPlatform:(XTSNSPlatform)platform;

/**
 *  分享链接信息
 *
 *  @param linkUrl     链接地址
 *  @param thumb       要显示的缩略图
 *  @param title       要分享的链接的标题
 *  @param description 要分享的链接描述
 *  @param platform    需要分享的平台
 */
+ (void)shareLink:(NSString *)linkUrl image:(UIImage *)image title:(NSString *)title description:(NSString *)description toPlatform:(XTSNSPlatform)platform;

@end

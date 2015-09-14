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
 *  @param message   分享消息
 *  @param shareType 分享类型
 */
+ (void)shareMessage:(OSMessage *)message withShareType:(XTSNSShareType)shareType;


@end

//
//  XTShareView.h
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTSNS.h"
#import "OpenShareHeader.h"

@interface XTShareView : UIControl

/// 便利方法获取分享视图
+ (instancetype)shareView;

/// 显示分享视图
- (void)showShareViewWithMessage:(OSMessage *)message completionHandler:(void (^)(OSMessage *message, NSError *error))completionHandler;


@end

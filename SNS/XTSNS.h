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
#import "XTSNSDefine.h"

@interface XTSNS : NSObject

//注册相应平台的信息
+ (void)registerWeiboAppId:(NSString *)appId secret:(NSString *)secret redirectURI:(NSString *)redirectURI;
+ (void)registerQQAppId:(NSString *)appId secret:(NSString *)secret;
+ (void)registerWeiXinAppId:(NSString *)appId secret:(NSString *)secret;

@end

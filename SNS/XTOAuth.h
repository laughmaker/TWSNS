//
//  XTOAuth.h
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XTSNSDefine.h"

/**
 *  第三方登录封装接口，提供登录，获取用户信息等
 */
@interface XTOAuth : NSObject

/**
 *  创建第三方登录实例便捷方法
 *
 *  @return 第三方登录实例
 */
+ (instancetype)oauth;

/**
 *  登录第三方接口
 *
 *  @param userType       用户类型，由XTUserType定义
 *  @param viewController 传入ViewController，由其展现登录界面
 *  @param completion     完成代理，返回相关数据
 */
- (void)loginWithUserType:(XTSNSPlatform)userType prentViewController:(UIViewController *)viewController completionHandle:(void (^)(NSDictionary *data, NSError *error))completion;

@end

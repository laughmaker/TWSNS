//
//  XTOAuth.h
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TWSNSRequest.h"
#import "TWSNS.h"
#import "TWSNSDefine.h"

/**
 *  第三方登录封装接口，提供登录，获取用户信息等
 */
@interface TWOAuth : NSObject

/**
 *  登录到第三方平台
 *
 *  @param platform          平台类型
 *  @param completionHandler 完成后的代理，成功后会返回用户信息，失败后会返回失败信息
 */
+ (void)loginToPlatform:(TWSNSPlatform)platform completionHandle:(void (^)(NSDictionary *data, NSError *error))completionHandler;

@end

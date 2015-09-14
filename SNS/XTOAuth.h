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
#import "OpenShareHeader.h"
//#import "Overline+BlocksKit.h"
#import "XTRequest.h"
#import "XTSNS.h"
#import "NSString+URL.h"

/**
 *  第三方登录封装接口，提供登录，获取用户信息等
 */
@interface XTOAuth : NSObject

+ (void)loginToPlatform:(XTSNSPlatform)platform completionHandle:(void (^)(NSDictionary *data, NSError *error))completionHandler;

@end

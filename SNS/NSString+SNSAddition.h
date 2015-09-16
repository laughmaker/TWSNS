//
//  NSString+URL.h
//  XTSNS
//
//  Created by 何振东 on 15/9/14.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNSAddition)

/// 将字符串进行Url编码
- (NSString *)encodeURL;

/// 将字符串进行Hash
- (NSString *)hmacSha1WithKey:(NSString *)key;

@end

//
//  NSString+URL.h
//  XTSNS
//
//  Created by 何振东 on 15/9/14.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@interface NSString (URL)


- (NSString *)encodeURL;

- (NSString *)hmacSha1WithKey:(NSString *)key;

@end

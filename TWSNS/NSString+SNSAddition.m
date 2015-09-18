//
//  NSString+URL.m
//  XTSNS
//
//  Created by 何振东 on 15/9/14.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "NSString+SNSAddition.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation NSString (SNSAddition)

- (NSString *)encodeURL
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$.,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)hmacSha1WithKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return hash;
}

@end

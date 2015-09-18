//
//  XTRequest.h
//  XTSNS
//
//  Created by 何振东 on 15/9/14.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWSNSRequest : NSObject

+ (void)get:(NSString *)urlPath completionHandler:(void (^)(id data, NSError *error))completionHandler;
+ (void)get:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

@end

//
//  XTOAuth.m
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import "XTOAuth.h"

@implementation XTOAuth

+ (instancetype)oauth
{
    return [[[self class] alloc] init];
}

- (void)loginWithUserType:(XTSNSPlatform)userType prentViewController:(UIViewController *)viewController completionHandle:(void (^)(NSDictionary *, NSError *))completion
{
    
}

@end

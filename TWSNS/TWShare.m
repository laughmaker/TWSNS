//
//  XTShare.m
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import "TWShare.h"
#import "OpenShareHeader.h"
#import "OpenShare.h"

@implementation TWShare

+ (instancetype)share
{
    return [[[self class] alloc] init];
}

+ (void)shareMessage:(OSMessage *)message withShareType:(TWSNSShareType)shareType completionHandler:(void (^)(OSMessage *message, NSError *error))completionHandler
{
    if (shareType == TWSNSShareTypeWeibo) {
        [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == TWSNSShareTypeQQZone) {
        [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == TWSNSShareTypeQQ) {
        [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == TWSNSShareTypeWXSceneTimeline) {
        [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == TWSNSShareTypeWXSceneSession) {
        [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    }
}


@end

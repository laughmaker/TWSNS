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

+ (void)shareMessage:(OSMessage *)message withShareType:(XTSNSShareType)shareType completionHandler:(void (^)(OSMessage *message, NSError *error))completionHandler
{
    if (shareType == XTSNSShareTypeWeibo) {
        [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == XTSNSShareTypeQQZone) {
        [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == XTSNSShareTypeQQ) {
        [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == XTSNSShareTypeWXSceneTimeline) {
        [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
            if (completionHandler) {
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (shareType == XTSNSShareTypeWXSceneSession) {
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

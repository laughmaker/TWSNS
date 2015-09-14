//
//  XTShare.m
//  
//
//  Created by 何振东 on 15/8/10.
//
//

#import "XTShare.h"

@implementation XTShare

+ (instancetype)share
{
    return [[[self class] alloc] init];
}

+ (void)shareMessage:(OSMessage *)message withShareType:(XTSNSShareType)shareType
{
    switch (shareType) {
        case XTSNSShareTypeWeibo:
            [OpenShare shareToWeibo:message Success:nil Fail:nil];
            break;
        case XTSNSShareTypeQQZone:
            [OpenShare shareToQQZone:message Success:nil Fail:nil];
            break;
        case XTSNSShareTypeQQ:
            [OpenShare shareToQQFriends:message Success:nil Fail:nil];
            break;
        case XTSNSShareTypeWXSceneTimeline:
            [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
                
            } Fail:^(OSMessage *message, NSError *error) {
                
            }];
            break;
        case XTSNSShareTypeWXSceneSession:
            [OpenShare shareToWeixinSession:message Success:nil Fail:nil];
            break;
        default:
            break;
    }
}


@end

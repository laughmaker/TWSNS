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

+ (void)shareMessage:(OSMessage *)message toPlatform:(XTSNSPlatform)platform
{
    switch (platform) {
        case XTSNSPlatformWeibo:
            [OpenShare shareToWeibo:message Success:nil Fail:nil];
            break;
        case XTSNSPlatformQQZone:
            [OpenShare shareToQQZone:message Success:nil Fail:nil];
            break;
        case XTSNSPlatformQQ:
            [OpenShare shareToQQFriends:message Success:nil Fail:nil];
            break;
        case XTSNSPlatformWXSceneTimeline:
            [OpenShare shareToWeixinTimeline:message Success:nil Fail:nil];
            break;
        case XTSNSPlatformWXSceneSession:
            [OpenShare shareToWeixinSession:message Success:nil Fail:nil];
            break;
        default:
            break;
    }
}

+ (void)shareText:(NSString *)text toPlatform:(XTSNSPlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = text;
    [[self class] shareMessage:message toPlatform:platform];
}

+ (void)shareText:(NSString *)text image:(UIImage *)image toPlatform:(XTSNSPlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = text;
    message.image = UIImageJPEGRepresentation(image, 1);
    [[self class] shareMessage:message toPlatform:platform];
}

+ (void)shareLink:(NSString *)linkUrl image:(UIImage *)image title:(NSString *)title description:(NSString *)description toPlatform:(XTSNSPlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = title;
    message.link = linkUrl;
    message.image = UIImageJPEGRepresentation(image, 1);
    [[self class] shareMessage:message toPlatform:platform];
}

@end

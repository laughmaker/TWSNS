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

+ (void)shareMessage:(OSMessage *)message toPlatform:(XTSharePlatform)platform
{
    switch (platform) {
        case XTSharePlatformWeibo:
            [OpenShare shareToWeibo:message Success:nil Fail:nil];
            break;
        case XTSharePlatformQQZone:
            [OpenShare shareToQQZone:message Success:nil Fail:nil];
            break;
        case XTSharePlatformQQ:
            [OpenShare shareToQQFriends:message Success:nil Fail:nil];
            break;
        case XTSharePlatformWXSceneTimeline:
            [OpenShare shareToWeixinTimeline:message Success:nil Fail:nil];
            break;
        case XTSharePlatformWXSceneSession:
            [OpenShare shareToWeixinSession:message Success:nil Fail:nil];
            break;
        default:
            break;
    }
}

+ (void)shareText:(NSString *)text toPlatform:(XTSharePlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = text;
    [[self class] shareMessage:message toPlatform:platform];
}

+ (void)shareText:(NSString *)text image:(UIImage *)image toPlatform:(XTSharePlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = text;
    message.image = UIImageJPEGRepresentation(image, 1);
    [[self class] shareMessage:message toPlatform:platform];
}

+ (void)shareLink:(NSString *)linkUrl image:(UIImage *)image title:(NSString *)title description:(NSString *)description toPlatform:(XTSharePlatform)platform
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = title;
    message.link = linkUrl;
    message.image = UIImageJPEGRepresentation(image, 1);
    [[self class] shareMessage:message toPlatform:platform];
}

@end

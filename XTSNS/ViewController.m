//
//  ViewController.m
//  XTSNS
//
//  Created by 何振东 on 15/9/8.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "ViewController.h"
#import "XTSNS.h"

/// 程序中用到的第三方帐号的相关Key和SecretKey
static NSString *const kWeChatAppId      = @"wxc070c02fb0a72487";
static NSString *const kUmengKey         = @"53d763cf56240bceda037f5f";
static NSString *const kQZoneID          = @"";
static NSString *const kQZoneKey         = @"";

@interface ViewController ()
- (IBAction)share:(id)sender;
- (IBAction)qqLogin:(id)sender;

- (IBAction)weiboLogin:(id)sender;
- (IBAction)weixinLogin:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (IBAction)share:(id)sender
{
    OSMessage *message = [[OSMessage alloc] init];
    message.title = @"我爱我的因我觉得欢喜~~~测试中，请忽略";
//    message.image = UIImageJPEGRepresentation([UIImage imageNamed:@"a"], 1);
//    message.desc = @"哈哈，这里是描述";
    [[XTShareView shareView] showShareViewWithMessage:message];
}

- (IBAction)qqLogin:(id)sender {
    [XTOAuth loginToPlatform:XTSNSPlatformQQ completionHandle:^(NSDictionary *data, NSError *error)
     {
         
     }];
}

- (IBAction)weiboLogin:(id)sender {
    [XTOAuth  loginToPlatform:XTSNSPlatformWeibo completionHandle:^(NSDictionary *data, NSError *error)
    {
        
    }];
}

- (IBAction)weixinLogin:(id)sender {
    [XTOAuth loginToPlatform:XTSNSPlatformWeiXin completionHandle:^(NSDictionary *data, NSError *error)
     {
         
     }];

}

@end

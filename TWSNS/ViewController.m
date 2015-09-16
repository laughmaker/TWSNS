//
//  ViewController.m
//  XTSNS
//
//  Created by 何振东 on 15/9/8.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "ViewController.h"
#import "TWSNS.h"


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
    message.title = @"我爱我的因我觉得欢喜~~~这里是你要分享的内容";
    message.image = UIImageJPEGRepresentation([UIImage imageNamed:@"a.jpg"], 0.1);
    message.thumbnail = UIImageJPEGRepresentation([UIImage imageNamed:@"a.jpg"], 0.1);
    message.desc = @"哈哈，这里是描述";
    message.link = @"http://www.3water3.com";
    [[TWShareView shareView] showShareViewWithMessage:message completionHandler:^(OSMessage *message, NSError *error) {
        NSLog(@"message:%@", message);
        NSLog(@"error:%@", error);
    }];
}

- (IBAction)qqLogin:(id)sender {
    [TWOAuth loginToPlatform:TWSNSPlatformQQ completionHandle:^(NSDictionary *data, NSError *error)
     {
         NSLog(@"data:%@", data);
         NSLog(@"error:%@", error);
     }];
}

- (IBAction)weiboLogin:(id)sender {
    [TWOAuth  loginToPlatform:TWSNSPlatformWeibo completionHandle:^(NSDictionary *data, NSError *error)
    {
        NSLog(@"data:%@", data);
        NSLog(@"error:%@", error);
    }];
}

- (IBAction)weixinLogin:(id)sender {
    [TWOAuth loginToPlatform:TWSNSPlatformWeiXin completionHandle:^(NSDictionary *data, NSError *error)
     {
         NSLog(@"data:%@", data);
         NSLog(@"error:%@", error);
     }];
}

@end

//
//  XTShareView.m
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "TWShareView.h"
#import "TWSNSDefine.h"
#import "TWShare.h"

static NSUInteger const kRankNum = 5;
static CGFloat const kSpace = 10;
static CGFloat const kTopMargin = 25;


#define kWidth (self.bounds.size.width - kSpace * (kRankNum + 1))/kRankNum

@interface TWShareView ()
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) OSMessage *message;

@property (nonatomic, copy) void (^shareCompletionHandler) (OSMessage *message, NSError *error);

@end

@implementation TWShareView


+ (instancetype)shareView
{
    return [[TWShareView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.3];
        [self addTarget:self action:@selector(hideSelf:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];

        NSArray *images = @[[UIImage imageNamed:@"share-weixin"],
                            [UIImage imageNamed:@"share-weixin-frends"],
                            [UIImage imageNamed:@"share-qq"],
                            [UIImage imageNamed:@"share-qqzone"],
                            [UIImage imageNamed:@"share-weibo"]];
        NSInteger rank = 0;
        for (int i = 0; i < images.count; i++) {
            NSInteger row = floor(i / kRankNum);
            CGRect rect = CGRectMake(kSpace + (kSpace + kWidth) * rank, kTopMargin + (kWidth + kTopMargin) * row, kWidth, kWidth);
            rank++;
            if (rank >= kRankNum) {
                rank = 0;
            }
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:images[i] forState:UIControlStateNormal];
            btn.frame = rect;
            btn.tag = 1 + i;
            [btn addTarget:self action:@selector(shareButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
        }
    }
    return self;
}

- (void)shareButtonClickEvent:(UIButton *)sender
{
    TWSNSShareType shareType = sender.tag;
    [TWShare shareMessage:self.message withShareType:shareType completionHandler:self.shareCompletionHandler];
    
    [self hideSelf:self];
}

- (void)showShareViewWithMessage:(OSMessage *)message completionHandler:(void (^)(OSMessage *message, NSError *error))completionHandler
{
    self.message = message;
    self.shareCompletionHandler = completionHandler;
    
    __weak TWShareView *weakSelf = self;

    UIView *window = [[UIApplication sharedApplication].keyWindow.subviews lastObject];
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 120);
    [window addSubview:self];

    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.contentView.frame = CGRectMake(0, weakSelf.bounds.size.height - kWidth - kTopMargin * 2 - 5, weakSelf.bounds.size.width, 400);
    } completion:nil];
}

- (void)hideSelf:(id)sender
{
    __weak TWShareView *weakSelf = self;
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.contentView.center = CGPointMake(weakSelf.contentView.center.x, weakSelf.bounds.size.height + weakSelf.contentView.bounds.size.height);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


#pragma getters && setters 

- (UIView *)contentView
{
    if (!_contentView) {
        NSInteger version = [[[UIDevice currentDevice] systemVersion] integerValue];
        if (version >= 8) {
            _contentView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        } else {
            _contentView = [[UIToolbar alloc] init];
        }
    }
    return _contentView;
}


@end

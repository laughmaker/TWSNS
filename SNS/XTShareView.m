//
//  XTShareView.m
//  XTSNS
//
//  Created by 何振东 on 15/9/9.
//  Copyright © 2015年 LZA. All rights reserved.
//

#import "XTShareView.h"
#import "FXBlurView.h"

static CGFloat const kRankNum = 5.0;
static CGFloat const kSpace = 10.0;

#define kWidth  ((self.bounds.size.width - kSpace * (kRankNum + 1))/kRankNum)

@interface XTShareView ()
@property (strong, nonatomic) FXBlurView *contentView;
@property (strong, nonatomic) OSMessage *message;

@end

@implementation XTShareView


+ (instancetype)shareView
{
    return [[XTShareView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.3];
        [self addTarget:self action:@selector(hideSelf:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];

        NSArray *images = @[[UIImage imageNamed:@"share-weixin@3x"],
                            [UIImage imageNamed:@"share-weixin-frends@3x"],
                            [UIImage imageNamed:@"share-qq@3x"],
                            [UIImage imageNamed:@"share-qqzone@3x"],
                            [UIImage imageNamed:@"share-weibo@3x"]];
        NSInteger rank = 0;
        for (int i = 0; i < images.count; i++) {
            NSInteger row = floor(i / kRankNum);
            CGRect rect = CGRectMake(kSpace + (kSpace + kWidth) * rank, kSpace + 5 + (kWidth + kSpace) * row, kWidth, kWidth);
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
    XTSNSPlatform platform = sender.tag;
    [XTShare shareMessage:self.message toPlatform:platform];
    
    [self hideSelf:self];
}

- (void)showShareViewWithMessage:(OSMessage *)message
{
    self.message = message;
    
    __weak XTShareView *weakSelf = self;

    UIView *window = [[UIApplication sharedApplication].keyWindow.subviews lastObject];
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 120);
    [window addSubview:self];
    self.contentView.underlyingView = window;

    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.contentView.frame = CGRectMake(0, weakSelf.bounds.size.height - kWidth - (kSpace + 5) * 2, weakSelf.bounds.size.width, 120);
    } completion:nil];
}

- (void)hideSelf:(id)sender
{
    __weak XTShareView *weakSelf = self;
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.contentView.center = CGPointMake(weakSelf.contentView.center.x, weakSelf.bounds.size.height + weakSelf.contentView.bounds.size.height);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


#pragma getters && setters 

- (FXBlurView *)contentView
{
    if (!_contentView) {
        _contentView = [[FXBlurView alloc] init];
    }
    return _contentView;
}


@end

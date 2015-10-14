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

#define m6Scale self.bounds.size.width/750.0
#define kSpace  43 * m6Scale
#define kWidth ((self.bounds.size.width - kSpace * (kRankNum + 1))/kRankNum)


@interface TWShareView ()
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UIButton *cancelBtn;

@property (strong, nonatomic) UIView *upLine;
@property (strong, nonatomic) UIView *downLine;

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
        self.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.2];
        [self addTarget:self action:@selector(hideSelf:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.cancelBtn];
        [self.contentView addSubview:self.upLine];
        [self.contentView addSubview:self.downLine];

        NSArray *images = @[[UIImage imageNamed:@"share-weixin"],
                            [UIImage imageNamed:@"share-weixin-frends"],
                            [UIImage imageNamed:@"share-qq"],
                            [UIImage imageNamed:@"share-qqzone"],
                            [UIImage imageNamed:@"share-weibo"]];
        NSInteger rank = 0;
        for (int i = 0; i < images.count; i++) {
            NSInteger row = floor(i / kRankNum);
            CGRect rect = CGRectMake(kSpace + (kSpace + kWidth) * rank, self.upLine.frame.origin.y + kSpace + (kWidth + kSpace) * row, kWidth, kWidth);
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
        CGFloat bottom = weakSelf.cancelBtn.frame.size.height + weakSelf.cancelBtn.frame.origin.y;
        weakSelf.contentView.frame = CGRectMake(0, weakSelf.bounds.size.height - bottom, weakSelf.bounds.size.width, 400);
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
        _contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 400);
    }
    return _contentView;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        CGRect frame = CGRectMake(0, 0, self.contentView.frame.size.width, 62 * m6Scale);
        _titleLbl = [[UILabel alloc] initWithFrame:frame];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:16];
        _titleLbl.text = @"分享至";
    }
    return _titleLbl;
}

- (UIView *)upLine
{
    if (!_upLine) {
        CGRect frame = CGRectMake(30 * m6Scale, self.titleLbl.frame.size.height + 20 * m6Scale, self.contentView.frame.size.width - 30 * m6Scale * 2, 0.5);
        _upLine = [[UIView alloc] initWithFrame:frame];
        _upLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _upLine.alpha = 0.5;
    }
    return _upLine;
}

- (UIView *)downLine
{
    if (!_downLine) {
        CGFloat y = self.upLine.frame.origin.y + kSpace * 2 + kWidth;
        CGRect frame = CGRectMake(self.upLine.frame.origin.x, y, self.upLine.frame.size.width, 0.5);
        _downLine = [[UIView alloc] initWithFrame:frame];
        _downLine.backgroundColor = _upLine.backgroundColor;
        _downLine.alpha = _upLine.alpha;
    }
    return _downLine;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBtn.frame = CGRectMake(0, self.downLine.frame.origin.y, self.contentView.frame.size.width, 100 * m6Scale);
        [_cancelBtn addTarget:self action:@selector(hideSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end

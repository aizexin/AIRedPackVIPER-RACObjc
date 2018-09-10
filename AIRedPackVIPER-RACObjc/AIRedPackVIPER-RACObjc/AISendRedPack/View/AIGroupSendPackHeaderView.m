//
//  AIGroupSendPackHeaderView.m
//  Tomato
//
//  Created by aizexin on 2018/9/6.
//

#import "AIGroupSendPackHeaderView.h"
#import "Masonry.h"
#import "AIScaleTool.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface AIGroupSendPackHeaderView()

/** 拼手气*/
@property(nonatomic,weak)UIButton *randomButton;
/** 普通红包*/
@property(nonatomic,weak)UIButton *normalButton;
/** 下划线*/
@property(nonatomic,weak)UIView *lineView;
@end

@implementation AIGroupSendPackHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        [self fitUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    {
        UIButton *button  = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.randomButton = button;
        [button setTitle:@"拼手气红包" forState:(UIControlStateNormal)];
        [button setTitleColor:UIColorRGB(0x666666) forState:(UIControlStateNormal)];
        [button setTitleColor:UIColorRGB(0xfa5f4b) forState:(UIControlStateSelected)];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font          = Font_PingFang_SC_Bold(15);
        self.randomSignal               = [[[button rac_signalForControlEvents:(UIControlEventTouchUpInside)]filter:^BOOL(__kindof UIControl * _Nullable value) {
            return !value.isSelected;
        }] doNext:^(UIButton *button) {
            button.selected = YES;
            [weakSelf.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button.mas_centerX);
                make.top.equalTo(self.randomButton.mas_bottom);
                make.bottom.equalTo(self);
                make.width.equalTo(@(AIScale_x(60)));
                make.height.equalTo(@2);
            }];
            [weakSelf updateLineLayout];
            weakSelf.normalButton.selected = NO;
        }];
        [self addSubview:button];
    }
    {
        UIButton *button  = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.normalButton = button;
        [button setTitle:@"普通红包" forState:(UIControlStateNormal)];
        [button setTitleColor:UIColorRGB(0x666666) forState:(UIControlStateNormal)];
        [button setTitleColor:UIColorRGB(0xfa5f4b) forState:(UIControlStateSelected)];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font          = Font_PingFang_SC_Bold(15);
        self.normalSignal               = [[[button rac_signalForControlEvents:(UIControlEventTouchUpInside)]filter:^BOOL(__kindof UIControl * _Nullable value) {
            return !value.isSelected;
        }] doNext:^(UIButton *button) {
            button.selected = YES;
            [weakSelf.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(button.mas_centerX);
                make.top.equalTo(self.randomButton.mas_bottom);
                make.bottom.equalTo(self);
                make.width.equalTo(@(AIScale_x(60)));
                make.height.equalTo(@2);
            }];
            [weakSelf updateLineLayout];
            weakSelf.randomButton.selected = NO;
        }];
        [self addSubview:button];
    }
    {
        UIView *lineView   = [[UIView alloc]init];
        self.lineView      = lineView;
        lineView.backgroundColor = UIColorRGB(0xfa5f4b);
        [self addSubview:lineView];
    }
}

- (void)updateLineLayout {
    [UIView animateWithDuration:1.0 animations:^{
        [self.lineView layoutIfNeeded];
    }];
}

- (void)fitUI {
    [self.randomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(self.normalButton.mas_width);
    }];
    [self.normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.randomButton.mas_right);
        make.right.top.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.randomButton.mas_bottom);
        make.bottom.equalTo(self);
        make.width.equalTo(@(AIScale_x(60)));
        make.centerX.equalTo(self.randomButton);
        make.height.equalTo(@2);
    }];
}

- (RACChannelTerminal*)getIsRandom {
    return RACChannelTo(self,randomButton.selected);
}
@end

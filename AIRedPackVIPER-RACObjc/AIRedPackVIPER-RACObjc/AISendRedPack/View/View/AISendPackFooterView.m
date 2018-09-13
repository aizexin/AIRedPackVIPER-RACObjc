//
//  AISendPackFooterView.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISendPackFooterView.h"
#import "Masonry.h"
#import "AIScaleTool.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface AISendPackFooterView()

@end

@implementation AISendPackFooterView

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
    UIButton *sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.sendButton      = sendButton;
    sendButton.layer.cornerRadius = 4;
    sendButton.backgroundColor = UIColorRGB(0xfa5f4b);
    [sendButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sendButton.titleLabel.font = Font_PingFang_SC_Medium(14);
    [sendButton setTitle:@"xxxx" forState:UIControlStateNormal];
    [self addSubview:sendButton];
    self.sendSignal = [sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)];
}

- (void)fitUI {
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(AIScale_x(-15)));
        make.left.equalTo(@(AIScale_x(15)));
        make.bottom.equalTo(self);
        make.height.equalTo(@(AIScale_y(44)));
    }];
}
@end

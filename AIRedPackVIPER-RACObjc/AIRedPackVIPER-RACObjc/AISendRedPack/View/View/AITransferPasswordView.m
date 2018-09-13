//
//  AITransferPasswordView.m
//  Tomato
//
//  Created by aizexin on 2018/6/11.
//

#import "AITransferPasswordView.h"
#import "TGPasswordFieldView.h"
#import "Masonry.h"
#import "AIScaleTool.h"

@interface AITransferPasswordView()
/** 取消按钮*/
@property(nonatomic,weak)UIButton *cancelButton;
/** 标题*/
@property(nonatomic,weak)UILabel *titleLabel;
/** 小标题*/
@property(nonatomic,weak)UILabel *subLabel;
/** 金额*/
@property(nonatomic,weak)UILabel *moneyLabel;
/** line*/
@property(nonatomic,weak)UIView *lineView2;
/** line*/
@property(nonatomic,weak)UIView *lineView1;
/** 密码*/
@property(nonatomic,weak)TGPasswordFieldView *passwordFieldView;
/** 忘记密码*/
@property(nonatomic,weak)UIButton *forgetPasswordButton;
@end

@implementation AITransferPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
        [self configurelayout];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    {//取消
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.cancelButton = button;
        [button setImage:[UIImage imageNamed:@"btn_x"] forState:(UIControlStateNormal)];
        [self addSubview:button];
        [button addTarget:self action:@selector(onClickCancel) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    {//标题
        UILabel *label      = [[UILabel alloc]init];
        self.titleLabel     = label;
        label.font          = [UIFont systemFontOfSize:14];
        label.textColor     = UIColorRGB(0x282828);
        label.text          = @"发送红包";
        [self addSubview:label];
    }
    
    {//线1
        UIView *lineView    = [[UIView alloc]init];
        lineView.backgroundColor = UIColorRGB(0xdddddd);
        self.lineView1       = lineView;
        [self addSubview:lineView];
    }
    
    {//小标题
        UILabel *label      = [[UILabel alloc]init];
        self.subLabel       = label;
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = UIColorRGB(0xababab);
        label.font          = [UIFont systemFontOfSize:14];
        label.text          = [NSString stringWithFormat:@"%@%@",@"xxx",@"小贝儿"];
        [self addSubview:label];
    }
    
    {//钱
        UILabel *label      = [[UILabel alloc]init];
        self.moneyLabel     = label;
        label.textColor     = UIColorRGB(0x282828);
        label.font          = [UIFont systemFontOfSize:18];
        label.text          = @"¥ 1200.00";
        [self addSubview:label];
    }
    
    {//线
        UIView *lineView    = [[UIView alloc]init];
        lineView.backgroundColor = UIColorRGB(0xdddddd);
        self.lineView2       = lineView;
        [self addSubview:lineView];
    }
    
    {//密码
        TGPasswordFieldView *password = [[TGPasswordFieldView alloc]init];
        self.passwordFieldView        = password;
        [self addSubview:password];
    }
    
    {//忘记密码
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.forgetPasswordButton = button;
        button.titleLabel.font    = [UIFont systemFontOfSize:14];
        [button setTitleColor:UIColorRGB(0x66a6ff) forState:(UIControlStateNormal)];
        [button setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        [self addSubview:button];
        [button addTarget:self action:@selector(onClickForget) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)configurelayout {
    //取消按钮
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(AIScale_x(13)));
        make.top.equalTo(@(AIScale_y(16)));
        make.width.equalTo(@(AIScale_x(14)));
        make.height.equalTo(@(AIScale_y(14)));
    }];
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.cancelButton.mas_top);
        make.height.equalTo(@(AIScale_y(14)));
    }];
    //线1
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(self.titleLabel.mas_bottom).offset = (AIScale_y(15));
    }];
    //子标题
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom).offset = 18;
        make.height.equalTo(@(AIScale_y(14)));
        make.width.equalTo(@(AIScale_x(220)));
    }];
    //钱
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.subLabel.mas_bottom).offset = (AIScale_y(11));
        make.height.equalTo(@14);
    }];
    //线
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset = (AIScale_y(19));
    }];
    //密码
    [self.passwordFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(AIScale_x(262)));
        make.height.equalTo(@(AIScale_y(44)));
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView2.mas_bottom).offset = (AIScale_y(12));
    }];
    //忘记密码
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset = AIScale_x(-10);
        make.bottom.equalTo(@(AIScale_y(-11)));
        make.height.equalTo(@(AIScale_y(15)));
        make.top.equalTo(self.passwordFieldView.mas_bottom).offset = AIScale_y(10);
    }];
}

#pragma mark action
- (void)onClickCancel {
    if ([self.delegate respondsToSelector:@selector(ai_transferPasswordViewOnClickCancel:)]) {
        [self.delegate ai_transferPasswordViewOnClickCancel:self];
    }
}

- (void)onClickForget {
    if ([self.delegate respondsToSelector:@selector(ai_transferPasswordViewOnClickForget:)]) {
        [self.delegate ai_transferPasswordViewOnClickForget:self];
    }
}
- (void)cleanPassword {
    [_passwordFieldView cleanPassword];
}
#pragma mark public
-(void)setPaswodPrepareComplete:(void (^)(NSDictionary *))paswodPrepareComplete {
    _paswodPrepareComplete = paswodPrepareComplete;
    self.passwordFieldView.paswodPrepareComplete = paswodPrepareComplete;
}

- (void)setType:(AITransferPasswordType)type
{
    _type = type;
}

-(void)setMoney:(NSString *)money {
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[money doubleValue]];
}
-(void)setName:(NSString *)name {
    _name = name;
    switch (_type) {
        case AITransferPassword_RedPacket:
            self.subLabel.text = @"Tomato 红包";
            break;
        case AITransferPassword_TransferAccount:
            self.subLabel.text = [NSString stringWithFormat:@"转账给%@",name];
            break;
        default:
            break;
    }
}

@end

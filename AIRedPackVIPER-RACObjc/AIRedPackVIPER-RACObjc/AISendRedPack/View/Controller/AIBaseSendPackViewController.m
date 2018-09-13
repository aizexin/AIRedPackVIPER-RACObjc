//
//  AIBaseSendPackViewController.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIBaseSendPackViewController.h"
#import "AIScaleTool.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "Masonry.h"
#import "AITransferPasswordView.h"

@interface AIBaseSendPackViewController () <UITableViewDelegate ,UITableViewDataSource,AITransferPasswordViewDelegate>
@property (nonatomic,assign)UIEdgeInsets safeAreInsets;
@property(nonatomic,weak)AITransferPasswordView *passwordView;
@property(nonatomic,strong)UIButton *coverButton;
@property (nonatomic,assign)BOOL isEnableButton;
@end

@implementation AIBaseSendPackViewController

- (UIButton *)coverButton {
    if (!_coverButton) {
        _coverButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _coverButton.backgroundColor = [UIColor blackColor];
        _coverButton.alpha = 0.;
        _coverButton.frame = [UIScreen mainScreen].bounds;
        [_coverButton addTarget:self action:@selector(onClickCoverButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _coverButton;
}

//MARK: life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.safeAreInsets        = [AIScaleTool calculatedSafeAreaInsetWithController:self];
    [self createUI];
    [self configureNavigation];
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.presenter bindIsEnableButton:RACChannelTo(self.footerView.sendButton, enabled)];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification*)notif {
    self.tableView.contentInset = UIEdgeInsetsZero;
}
- (void)keyboardWillHide:(NSNotification*)notif {
    self.tableView.contentInset = UIEdgeInsetsZero;
}
- (void)createUI {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    
    self.tableView         = tableView;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.rowHeight = 44;
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColorRGB(0xf2f2f2);
    [tableView registerClass:[AIRedPackTableViewCell class] forCellReuseIdentifier:AIRedPackTableViewCell_identifer];
    [tableView registerClass:[AIGreetingTableViewCell class] forCellReuseIdentifier:AIGreetingTableViewCell_identifer];
    [tableView registerClass:[AISendPackSectionHeaderView class] forHeaderFooterViewReuseIdentifier:AISendPackSectionHeaderView_identifer];
    [self.view addSubview:tableView];
    
    //ADD tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.tableView addGestureRecognizer:tap];
    
    AISendPackFooterView *footerView = [[AISendPackFooterView alloc]init];
    self.footerView                  = footerView;
    footerView.frame                 = CGRectMake(0, 0, self.view.bounds.size.width, AIScale_y(141+48));
    
    __weak typeof(self)weakSelf      = self;
    [[footerView.sendSignal filter:^BOOL(id  _Nullable value) {
        if (!weakSelf.isSetPayPassword) {
            //TODO:alert提示;
        }
        return weakSelf.isSetPayPassword;
    }] subscribeNext:^(id  _Nullable x) {
        [weakSelf showPasswordView];
    } error:^(NSError * _Nullable error) {
        
    }];
    self.tableView.tableFooterView   = self.footerView;
    
    CGFloat top  = self.safeAreInsets.top + 44;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(@(top));
        make.bottom.equalTo(@(-self.safeAreInsets.bottom));
    }];
    RAC(self.footerView.sendButton,backgroundColor) = [RACObserve(self.footerView.sendButton, enabled) map:^id _Nullable(NSNumber *value) {
        return [value boolValue] ? UIColorRGBA(0xfa5f4b,1): UIColorRGBA(0xfa5f4b,0.8);
    }];

}

- (void)configureNavigation {
    self.navigationItem.title = @"发送红包";
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"NavigationBackArrowNormal"]    forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(0, 0, 15, 44)];
    [btn1 addTarget:self action:@selector(dismissRedPacketController) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn2 setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn2 setFrame:CGRectMake(15, 0, 60, 44)];
    [btn2 addTarget:self action:@selector(dismissRedPacketController) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *view = [[UIView alloc]init];
    view.frame   = CGRectMake(0, 0, 75, 44);
    view.userInteractionEnabled = YES;
    [view addSubview:btn1];
    [view addSubview:btn2];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"详情" style:(UIBarButtonItemStylePlain) target:self action:@selector(onClickRight)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(RACChannelTerminal *)getSingleMaxMoneyChannel {
    return nil;
}

//MARK: Action
- (void)dismissRedPacketController {
    [self.presenter loadConfig];
//    [self.presenter dismissFromVC:self];
}

- (void)onClickRight {
    [self.presenter pushToDetailVCFromVC:self];
}

- (void)onClickCoverButton:(__unused UIButton*)button {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2f animations:^{
            _coverButton.alpha  = 0.;
            _passwordView.alpha = 0.;
        } completion:^(__unused BOOL finished) {
            [_coverButton removeFromSuperview];
            [_passwordView removeFromSuperview];
        }];
    });
}

- (void)showPasswordView {
    [[UIApplication sharedApplication].keyWindow addSubview:self.coverButton];
    AITransferPasswordView *passwordView = [[AITransferPasswordView alloc]init];
    self.passwordView  = passwordView;
    passwordView.type  = AITransferPassword_RedPacket;
    passwordView.money = [self.presenter getTotalMoney];
    passwordView.name  = @"xxx";//user.displayName;
    passwordView.alpha = 0.f;
    passwordView.delegate = self;
    __weak typeof(self)weakSelf = self;
    passwordView.paswodPrepareComplete = ^(NSDictionary *pasworInfo) {
        //完成密码输入
        RACCommand *command = [weakSelf.presenter commitRedPack];
        RACSignal *signal   = [command execute:pasworInfo[@"password"]];
        [signal subscribeNext:^(id  _Nullable x) {
            [weakSelf onClickCoverButton:nil];
            [weakSelf.presenter dismissFromVC:weakSelf];
        } error:^(NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.userInfo[@"error"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            });
            [weakSelf onClickCoverButton:nil];
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:passwordView];
    __weak AITransferPasswordView *weakPassView = passwordView;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.coverButton.alpha = 0.5;
        weakPassView.alpha = 1.;
    } completion:nil];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(AIScale_y(230)));
        make.width.equalTo(@(AIScale_x(343)));
        make.top.equalTo(@(AIScale_y(118)));
    }];
}
#pragma mark AITransferPasswordViewDelegate
-(void)ai_transferPasswordViewOnClickForget:(__unused AITransferPasswordView *)passwordView {
    [self onClickCoverButton:nil];
    [self.presenter pushToResetPasswordVCFromVC:self];
}

-(void)ai_transferPasswordViewOnClickCancel:(__unused AITransferPasswordView *)passwordView {
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];
    });
    [self onClickCoverButton:nil];
}

-(void)tap {
    [self.view endEditing:YES];
}

@end

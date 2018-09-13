//
//  AISendPackInteractor.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISendPackInteractor.h"
#import "AISendPackEntity.h"
#import "AISendPackConfigEntity.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "AISendPackNetworkManager.h"
@interface AISendPackInteractor()

/**
 最后的结果
 */
@property (nonatomic, strong)AISendPackEntity *resultEntity;
/**
 配置
 */
@property (nonatomic, strong)AISendPackConfigEntity *configEntity;
/**
 请求配置的多发信号
 */
@property (nonatomic,strong)RACMulticastConnection *loadConfigConnect;
/** 组的大小信号*/
@property(nonatomic,strong)RACSignal *groupSizeSignal;
/** 是否设置密码*/
@property(nonatomic,strong)RACSignal *isSetPaypasswordSignal;
/** 提示*/
@property(nonatomic,strong)RACChannelTerminal *tipsChannel;
/** 是否能点击*/
@property(nonatomic,strong)RACChannelTerminal *isEnableButtonChannel;
/** 总金额*/
@property(nonatomic,strong)RACChannelTerminal *totalMoneyChannel;
/** 单个金额*/
@property(nonatomic,strong)RACChannelTerminal *onePackMoneyChannel;
/** 祝福语*/
@property(nonatomic,strong)RACChannelTerminal *greetingChannel;
/** 红包数*/
@property(nonatomic,strong)RACChannelTerminal *packNumberChannel;
/** 是否是随机红包*/
@property(nonatomic,strong)RACChannelTerminal *isRandomPackChannel;
@end

@implementation AISendPackInteractor
@synthesize conversationId = _conversationId;

//MARK: ------life cycle
- (instancetype)initWithConversationId:(int64_t)conversationId {
    self = [super init];
    if (self) {
        _conversationId = conversationId;
        self.resultEntity   = [[AISendPackEntity alloc]init];
        //AI 默认是单聊，如果在群聊会在绑定的时候改变
        self.resultEntity.type = AISendPackType_Single;
        self.configEntity   = [[AISendPackConfigEntity alloc]init];
        
        __weak typeof(self)weakSelf = self;
        //初始化信号监听
        [self _initSignal];
        //加载配置
        [[self _loadConfig] subscribeNext:^(AISendPackConfigEntity *responseModel) {
            weakSelf.configEntity = responseModel;
            weakSelf.configEntity.isEnableButton          = [weakSelf _validateEnableButton];
        }error:^(NSError * _Nullable error) {
            NSLog(@"-----获取配置失败");
        }];
    }
    return self;
}

//MARK: -----private func

- (void)_initSignal {
    __weak typeof(self)weakSelf = self;
    //handing red packets
    RACSignal *packNumbserSignal = [RACObserve(self, resultEntity.packNumber) distinctUntilChanged];
    //总金额变化 -->单个金额变化
    RACSignal *totalMoneySignal =[RACObserve(self, resultEntity.totalMoney) distinctUntilChanged];
    //单个金额变化 -->总金额变化
    RACSignal *onePackMoneySignal = [RACObserve(self, resultEntity.onePackMoney) distinctUntilChanged];
    
    RACSignal *mergeSignal      = [RACSignal merge:@[totalMoneySignal,onePackMoneySignal,packNumbserSignal]];
    [[mergeSignal filter:^BOOL(id  _Nullable value) {
        return weakSelf.resultEntity.type != AISendPackType_Single;
    }] subscribeNext:^(id  _Nullable x) {
        if (weakSelf.resultEntity.isRandom) {
            CGFloat totalMoney   = MAX(weakSelf.resultEntity.totalMoney.floatValue, 0);
            NSInteger packNumber = MAX(weakSelf.resultEntity.packNumber.integerValue, 1);
            CGFloat onePackMoney = totalMoney / packNumber;
            weakSelf.resultEntity.onePackMoney = [NSString stringWithFormat:@"%.2f",onePackMoney];
        } else {
            NSInteger packNumber = MAX(weakSelf.resultEntity.packNumber.integerValue, 1);
            CGFloat onePackMoney = MAX(weakSelf.resultEntity.onePackMoney.floatValue, 0);
            CGFloat totalMoney   = packNumber * onePackMoney;
            weakSelf.resultEntity.totalMoney = [NSString stringWithFormat:@"%.2f",totalMoney];
        }
    }];
    
    //监听红包类型
    [[RACObserve(self, resultEntity.isRandom) filter:^BOOL(id  _Nullable value) {
        return weakSelf.resultEntity.type != AISendPackType_Single;
    }]subscribeNext:^(NSNumber *x) {
        if ([x boolValue]) {
            weakSelf.resultEntity.type = AISendPackType_Group_Random;
        } else {
            weakSelf.resultEntity.type = AISendPackType_Group_Normal;
        }
    }];
    
    RACSignal *mergeIsEnableButtonSignal = [RACSignal merge:@[mergeSignal,RACObserve(weakSelf, resultEntity.isRandom),[RACObserve(self, configEntity.isEnableButton) distinctUntilChanged]]];
    [mergeIsEnableButtonSignal subscribeNext:^(id  _Nullable x) {
        weakSelf.configEntity.isEnableButton = [weakSelf _validateEnableButton];
    }];    
}

- (RACSignal*)_loadConfig {
    if (!self.loadConfigConnect) {
        _loadConfigConnect = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //TODO:网络加载配置 最后必须在主线程完成传递数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //配置里面的都是分，所以待会要除以100
                AISendPackConfigEntity *config = [[AISendPackConfigEntity alloc]init];
                config.redPacketSingleMoneyMin = [NSNumber numberWithFloat:1];
                config.redPacketGroupMoneyMax  = [NSNumber numberWithFloat:20000];
                config.payPassword             = @(1);
                [subscriber sendNext:config];
            });
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }]publish];
        [_loadConfigConnect connect];
    }
    return _loadConfigConnect.signal;
}

/**
 验证按钮是否可以被点击
 */
- (BOOL)_validateEnableButton {
    CGFloat totalMoney     = self.resultEntity.totalMoney.floatValue * 100;
    CGFloat singleMaxMoney = self.configEntity.redPacketSingleMoneyMax.floatValue;
    CGFloat minMoney       = self.configEntity.redPacketSingleMoneyMin.floatValue;
    CGFloat groupMaxMoney  = self.configEntity.redPacketGroupMoneyMax.floatValue;
    switch (self.resultEntity.type) {
        case AISendPackType_Single:{
            if (totalMoney > singleMaxMoney) {
                self.configEntity.tips = [NSString stringWithFormat:@"红包最大金额不能超过%.2f元",singleMaxMoney / 100.];
                return NO;
            }
            if (totalMoney < minMoney) {
                self.configEntity.tips = [NSString stringWithFormat:@"红包最小金额为%.2f元",minMoney / 100.];
                return NO;
            }
            
        }
            break;
        case AISendPackType_Group_Normal:
        case AISendPackType_Group_Random:{
            if (totalMoney > groupMaxMoney) {
                self.configEntity.tips = [NSString stringWithFormat:@"群红包最大金额不能超过%.2f元",groupMaxMoney / 100.];
                return NO;
            }
            if (totalMoney < minMoney) {
                self.configEntity.tips = [NSString stringWithFormat:@"红包最小金额为%.2f元",minMoney / 100.];
                return NO;
            }
        }
            break;
            
        default:
            break;
    }
    //如果输入正确想清空提示
//    self.configEntity.tips     = @"";
    return YES;
}

//MARK:--------------public func
- (RACSignal*)getGroupSizeSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //TODO:获取人数
        [subscriber sendNext:[NSNumber numberWithInteger:2]];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (RACSignal*)getIsSetPaypasswordSignal {
    return RACObserve(self, configEntity.payPassword);
}

//MARK:结果绑定
-(RACChannelTerminal *)getTipsChannel {
    if (!_tipsChannel) {
        _tipsChannel = RACChannelTo(self, configEntity.tips);
    }
    return _tipsChannel;
}
- (RACChannelTerminal*)getIsEnableButtonChannel {
    if (!_isEnableButtonChannel) {
        _isEnableButtonChannel = RACChannelTo(self, configEntity.isEnableButton ,@(NO));
    }
    return _isEnableButtonChannel;
}
-(RACChannelTerminal *)getTotalMoneyChannel {
    if (!_totalMoneyChannel) {
        _totalMoneyChannel = RACChannelTo(self, resultEntity.totalMoney);
    }
    return _totalMoneyChannel;
}
-(RACChannelTerminal *)getOnePackMoneyChannel {
    if (!_onePackMoneyChannel) {
        _onePackMoneyChannel = RACChannelTo(self, resultEntity.onePackMoney);
    }
    return _onePackMoneyChannel;
}
-(RACChannelTerminal *)getGreetingChannel {
    if (!_greetingChannel) {
        _greetingChannel = RACChannelTo(self, resultEntity.greetings);
    }
    return _greetingChannel;
}
- (RACChannelTerminal*)getPackNumberChannel {
    if (!_packNumberChannel) {
        _packNumberChannel = RACChannelTo(self, resultEntity.packNumber);
    }
    return _packNumberChannel;
}
-(RACChannelTerminal*)getIsRandomPackChannel {
    if (!_isRandomPackChannel) {
        self.resultEntity.type = AISendPackType_Group_Random;
        _isRandomPackChannel = RACChannelTo(self, resultEntity.isRandom);
    }
    return _isRandomPackChannel;
}

- (RACCommand*)commitRedPack {
    //TODO:网络请求提交红包
    return [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSString *password) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //这一部分是通过 网络处理发送红包
            [subscriber sendNext:nil];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

- (NSString*)getTotalMoney {
    return self.resultEntity.totalMoney;
}
@end

//
//  AISendPackPresneter.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISendPackPresneter.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation AISendPackPresneter

-(void)dismissFromVC:(UIViewController *)fromVC{
    [self.route dismissFromVC:fromVC];
}

-(void)pushToDetailVCFromVC:(UIViewController *)fromVC {
    [self.route pushToDetailVCFromVC:fromVC];
}
- (void)pushToResetPasswordVCFromVC:(UIViewController*)fromVC {
    [self.route pushToResetPasswordVCFromVC:fromVC];
}
- (void)pushToSettingPasswordVCFromVC:(UIViewController*)fromVC {
    [self.route pushToSettingPasswordVCFromVC:fromVC];
}

-(RACSignal *)loadConfig {
    RACSignal *groupSizeSignal = [self.interactor getGroupSizeSignal];
    RACSignal *isSetpaypassword = [self.interactor getIsSetPaypasswordSignal];
    RACSignal *combineSignal = [RACSignal combineLatest:@[groupSizeSignal,isSetpaypassword]];
    return combineSignal;
}

-(void)bindTotalMoney:(RACChannelTerminal *)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getTotalMoneyChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}

-(void)bindGreeting:(RACChannelTerminal *)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getGreetingChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}
- (void)bindTips:(RACChannelTerminal*)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getTipsChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}
- (void)bindIsEnableButton:(RACChannelTerminal*)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getIsEnableButtonChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}

- (RACCommand*)commitRedPack {
    return [self.interactor commitRedPack];
}

-(void)bindGroupPackNumber:(RACChannelTerminal *)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getPackNumberChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}

-(void)bindIsRandomPack:(RACChannelTerminal *)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getIsRandomPackChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}
- (void)bindGroupOnePackMoney:(RACChannelTerminal*)channel {
    RACChannelTerminal *interactorChannel = [self.interactor getOnePackMoneyChannel];
    [interactorChannel subscribe:channel];
    [channel subscribe:interactorChannel];
}
- (NSString*)getTotalMoney {
    return [self.interactor getTotalMoney];
}
@end

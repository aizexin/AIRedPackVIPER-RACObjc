//
//  AISendPackPresenterProtocol.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#ifndef AISendPackPresenterProtocol_h
#define AISendPackPresenterProtocol_h
#import <UIKit/UIKit.h>
#import "AISendPackEnum.h"
@class RACSignal;
@class RACChannelTerminal,RACCommand ,RACReplaySubject;
@protocol AISendPackPresenterProtocol <NSObject>

//控制route
- (void)dismissFromVC:(UIViewController *)fromVC;
- (void)pushToDetailVCFromVC:(UIViewController*)fromVC;
- (void)pushToResetPasswordVCFromVC:(UIViewController*)fromVC;
- (void)pushToSettingPasswordVCFromVC:(UIViewController*)fromVC;

//控制interactor
- (RACSignal*)loadConfig;
- (NSString*)getTotalMoney;
- (void)bindTotalMoney:(RACChannelTerminal*)channel;
- (void)bindGreeting:(RACChannelTerminal*)channel;
- (void)bindTips:(RACChannelTerminal*)channel;
- (void)bindIsEnableButton:(RACChannelTerminal*)channel;
- (RACCommand*)commitRedPack;

//MARK:group相关绑定
- (void)bindGroupPackNumber:(RACChannelTerminal*)channel;
- (void)bindIsRandomPack:(RACChannelTerminal*)channel;
- (void)bindGroupOnePackMoney:(RACChannelTerminal*)channel;
@end
#endif /* AISendPackPresenterProtocol_h */

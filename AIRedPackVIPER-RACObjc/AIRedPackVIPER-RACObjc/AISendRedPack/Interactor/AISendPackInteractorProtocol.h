//
//  AISendPackInteractorProtocol.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#ifndef AISendPackInteractorProtocol_h
#define AISendPackInteractorProtocol_h
#import "AISendPackEnum.h"
@class RACSignal,RACChannelTerminal,RACCommand,RACReplaySubject;
@protocol AISendPackInteractorProtocol <NSObject>
@property (nonatomic) int64_t conversationId;
- (instancetype)initWithConversationId:(int64_t)conversationId;
//MARK: 配置相关
- (RACSignal*)getIsSetPaypasswordSignal;
- (RACSignal*)getGroupSizeSignal;

- (RACChannelTerminal*)getIsEnableButtonChannel;

- (RACChannelTerminal*)getTipsChannel;
- (RACChannelTerminal*)getTotalMoneyChannel;
- (RACChannelTerminal*)getGreetingChannel;

- (RACCommand*)commitRedPack;

-(RACChannelTerminal*)getPackNumberChannel;
-(RACChannelTerminal*)getIsRandomPackChannel;
-(RACChannelTerminal *)getOnePackMoneyChannel;

- (NSString*)getTotalMoney;
@end
#endif /* AISendPackInteractorProtocol_h */

//
//  AIGroupSendPackHeaderView.h
//  Tomato
//
//  Created by aizexin on 2018/9/6.
//

#import <UIKit/UIKit.h>

@class RACSignal,RACChannelTerminal;
@interface AIGroupSendPackHeaderView : UIView
/** 点击信号*/
@property(nonatomic,strong)RACSignal *randomSignal;
/** 点击信号*/
@property(nonatomic,strong)RACSignal *normalSignal;
- (RACChannelTerminal*)getIsRandom;
@end

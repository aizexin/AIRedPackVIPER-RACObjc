//
//  AISendPackFooterView.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import <UIKit/UIKit.h>
@class RACSignal;
@interface AISendPackFooterView : UIView

/** 点击信号*/
@property(nonatomic,strong)RACSignal *sendSignal;
/** 按钮*/
@property(nonatomic,weak)UIButton *sendButton;
@end

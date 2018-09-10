//
//  AIGroupSendRedPackModel.h
//  Tomato
//
//  Created by aizexin on 2018/9/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AIBaseSendPackCellModel;
@interface AIGroupSendRedPackModel : NSObject
@property(nonatomic,strong)NSMutableArray<AIBaseSendPackCellModel*> *listArray;
@property(nonatomic,assign)CGFloat headerHeight;
@property(nonatomic,assign)CGFloat footerHeight;
/** 提示语*/
@property(nonatomic,copy)NSString *headerTips;
@end

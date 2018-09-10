//
//  AIGreetingCellModel.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIBaseSendPackCellModel.h"

@interface AIGreetingCellModel : AIBaseSendPackCellModel
/** 展位文字 */
@property(nonatomic,copy)NSString *plceholder;
/** 输入文字 */
@property(nonatomic,copy)NSString *text;
@end

//
//  AIRedPackCellModel.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIBaseSendPackCellModel.h"

@interface AIRedPackCellModel : AIBaseSendPackCellModel
/** 左边文字*/
@property(nonatomic,copy)NSAttributedString *leftString;
/** 右边文字*/
@property(nonatomic,copy)NSString *rightString;
/** 展位文字 */
@property(nonatomic,copy)NSString *plceholder;
/** 输入文字 */
@property(nonatomic,copy)NSString *text;
@end

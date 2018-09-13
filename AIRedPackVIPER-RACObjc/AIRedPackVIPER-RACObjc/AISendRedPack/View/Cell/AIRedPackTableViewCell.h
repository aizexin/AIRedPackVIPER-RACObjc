//
//  AIRedPackTableViewCell.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"

static NSString *AIRedPackTableViewCell_identifer = @"AIRedPackTableViewCell_identifer";
@interface AIRedPackTableViewCell : UITableViewCell
/** 左边视图*/
@property(nonatomic,weak)YYLabel *leftLabel;
/** 输入框*/
@property(nonatomic,weak)UITextField *textField;
/** 右边视图*/
@property(nonatomic,weak)UILabel *rightLabel;
@end

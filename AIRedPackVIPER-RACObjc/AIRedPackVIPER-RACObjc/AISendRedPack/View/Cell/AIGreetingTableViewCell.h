//
//  AIGreetingTableViewCell.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import <UIKit/UIKit.h>

static NSString *AIGreetingTableViewCell_identifer = @"AIGreetingTableViewCell_identifer";
@interface AIGreetingTableViewCell : UITableViewCell
/** 输入框*/
@property(nonatomic,weak)UITextField *textField;
@end

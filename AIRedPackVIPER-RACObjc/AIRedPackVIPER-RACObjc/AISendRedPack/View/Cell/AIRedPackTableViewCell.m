//
//  AIRedPackTableViewCell.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIRedPackTableViewCell.h"
#import "Masonry.h"
#import "AIScaleTool.h"
#import <NSAttributedString+YYText.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "RegexManager.h"
@interface AIRedPackTableViewCell()<UITextFieldDelegate>

@end

@implementation AIRedPackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self fitUI];
    }
    return self;
}

//-(void)prepareForReuse {
//    [super prepareForReuse];
//    [self.textField.rac_deallocDisposable dispose];
//}

- (void)createUI {
    YYLabel *leftLabel = [[YYLabel alloc]init];
    self.leftLabel     = leftLabel;
    [self.contentView addSubview:leftLabel];
    
    UILabel *rightLabel     = [[UILabel alloc]init];
    self.rightLabel         = rightLabel;
    rightLabel.font         = Font_PingFang_SC_Medium(13);
    rightLabel.frame        = CGRectMake(0, 0, 14, 13);
    rightLabel.textColor    = UIColorRGB(0x333333);
    [self.contentView addSubview:rightLabel];
    
    UITextField *textField  = [[UITextField alloc]init];
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate      = self;
    textField.keyboardType  = UIKeyboardTypeNumbersAndPunctuation;
    textField.font          = Font_PingFang_SC_Medium(14);
    textField.textColor     = UIColorRGB(0x333333);
    self.textField          = textField;
    [self.contentView addSubview:textField];
    
}

- (void)fitUI {
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(AIScale_x(15)));
        make.centerY.equalTo(self);
        make.width.equalTo(@(AIScale_x(60)));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right).offset = AIScale_x(8);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.rightLabel.mas_left).offset = AIScale_x(-8);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right).offset = AIScale_x(8);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(AIScale_x(-15)));
        make.width.equalTo(@14);
    }];
}

//MARK:UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = textField.text;
    str = [str stringByReplacingCharactersInRange:range withString:string];
    if ([str existWithRegexPattern:@"^([1-9]\\d*\\.\\d{0,2}|0\\.\\d{0,2}|[1-9]\\d*|0|"")$"]) {
        return YES;
    } else {
        return NO;
    }
}

@end

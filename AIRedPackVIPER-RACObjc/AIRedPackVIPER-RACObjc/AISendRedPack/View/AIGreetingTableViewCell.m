//
//  AIGreetingTableViewCell.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIGreetingTableViewCell.h"
#import "Masonry.h"
#import "AIScaleTool.h"
@interface AIGreetingTableViewCell()

@end

@implementation AIGreetingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //故意留空
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self fitUI];
    }
    return self;
}         

- (void)createUI {
    UITextField *textField  = [[UITextField alloc]init];
    textField.font          = Font_PingFang_SC_Medium(14);
    textField.textColor     = UIColorRGB(0x333333);
    textField.placeholder   = @"祝福语：恭喜发财，大吉大利";
    self.textField          = textField;
    [self.contentView addSubview:textField];
}

- (void)fitUI {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(AIScale_x(15)));
        make.right.top.bottom.equalTo(self);
    }];
}
@end

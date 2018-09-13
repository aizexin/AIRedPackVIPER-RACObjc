//
//  AISendPackSectionHeaderView.m
//  Tomato
//
//  Created by aizexin on 2018/9/10.
//

#import "AISendPackSectionHeaderView.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
@implementation AISendPackSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label       = [[UILabel alloc]init];
        _label               = label;
        _label.textAlignment = NSTextAlignmentRight;
        _label.textColor     = UIColorRGB(0xaaaaaa);
        _label.font          = Font_PingFang_SC_Medium(12);
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.contentView);
            make.right.equalTo(@(-15));
        }];
    }
    return self;
}

@end

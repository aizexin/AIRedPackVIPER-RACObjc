#import "TGPasswordFieldView.h"

#import "TGPasswordTextField.h"


@interface TGPasswordFieldView ()<UITextFieldDelegate>

@property (nonatomic, retain) TGPasswordTextField *textField;
@property (nonatomic, retain) NSMutableArray *lineArray;
@property (nonatomic, retain) NSMutableArray *dotArray;

@end

@implementation TGPasswordFieldView

- (void)initPwdTextField {
    
    
    int _kDotCount = 6;
    CGFloat _K_Field_Height = (45.0f);
    CGSize _kDotSize = CGSizeMake((20.0f), (20.0f));
    
    if (_textField.superview == nil) {
        [self addSubview:self.textField];
    }
    
    [self.textField becomeFirstResponder];
    
    _textField.frame = CGRectMake((10.0f), 9.0f, self.frame.size.width - 20.0f, _K_Field_Height);
    
    CGFloat width = CGRectGetWidth(self.textField.frame) / _kDotCount;
    
    
    if (_lineArray == nil) {
        self.lineArray = [NSMutableArray array];
        for (int i = 0; i < _kDotCount - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10.0f + (i + 1) * width + i * .01f, CGRectGetMinY(self.textField.frame), 1.0f, _K_Field_Height)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
            [self.lineArray addObject:lineView];
        }
        
    } else {
        
        for (int i = 0; i < _kDotCount - 1; i++) {
            UIView *line = [self.lineArray objectAtIndex:i];
            line.frame = CGRectMake(10.0f + (i + 1) * width + i * .01f, CGRectGetMinY(self.textField.frame), 1.0f, _K_Field_Height);
        }
        
    }
    
    if (_dotArray == nil) {
        self.dotArray = [NSMutableArray array];
        
        for (int i = 0; i < _kDotCount; i++) {
            UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - _kDotSize.width) / 2 + i * width + i * .25f, CGRectGetMinY(self.textField.frame) + (_K_Field_Height - _kDotSize.height) / 2, _kDotSize.width, _kDotSize.height)];
            dotView.backgroundColor = [UIColor blackColor];
            dotView.layer.cornerRadius = _kDotSize.width / 2.0f;
            dotView.clipsToBounds = YES;
            dotView.hidden = YES;
            [self addSubview:dotView];
            [self.dotArray addObject:dotView];
        }
    } else {
        for (int i = 0; i < _kDotCount; i++) {
            UIView *dotView = [self.dotArray objectAtIndex:i];
            dotView.frame = CGRectMake(CGRectGetMinX(self.textField.frame) + (width - _kDotSize.width) / 2 + i * width + i * .25f, CGRectGetMinY(self.textField.frame) + (_K_Field_Height - _kDotSize.height) / 2, _kDotSize.width, _kDotSize.height);
        }
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initPwdTextField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)__unused range replacementString:(NSString *)string {
    
    NSUInteger _kDotCount = 6;
    if([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        
        return YES;
    } else if(textField.text.length >= _kDotCount) {
        NSLog(@"password lenth more than 6，neglect it");
        return NO;
    } else {
        return YES;
    }
}

- (void)cleanPassword {
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (NSUInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    NSUInteger _kDotCount = 6;
    if (textField.text.length == _kDotCount) {
        NSLog(@"输入完毕");
        NSDictionary *passwordDic = @{@"password":textField.text};
        self.paswodPrepareComplete(passwordDic);
    }
}

- (UITextField *)textField
{
    if (_textField == nil) {
        
        _textField = [[TGPasswordTextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end


#import "TGPasswordTextField.h"

@implementation TGPasswordTextField

- (BOOL)canPerformAction:(SEL)__unused action withSender:(id)__unused sender {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end

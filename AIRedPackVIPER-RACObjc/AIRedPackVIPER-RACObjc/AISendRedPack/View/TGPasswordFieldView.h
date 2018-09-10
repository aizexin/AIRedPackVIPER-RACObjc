#import <UIKit/UIKit.h>

@interface TGPasswordFieldView : UIView

@property (nonatomic, copy) void (^paswodPrepareComplete) (NSDictionary *pasworInfo);

- (void)cleanPassword;

@end

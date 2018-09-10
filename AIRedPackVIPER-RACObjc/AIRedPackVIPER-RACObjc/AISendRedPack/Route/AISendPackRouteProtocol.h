//
//  AISendPackRouteProtocol.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#ifndef AISendPackRouteProtocol_h
#define AISendPackRouteProtocol_h
#import <UIKit/UIKit.h>
@class AIBaseSendPackViewController;
@protocol AISendPackRouteProtocol <NSObject>
- (void)dismissFromVC:(UIViewController *)fromVC ;
- (void)pushToDetailVCFromVC:(UIViewController*)fromVC;
- (void)pushToResetPasswordVCFromVC:(UIViewController*)fromVC;
- (void)pushToSettingPasswordVCFromVC:(UIViewController*)fromVC;
@end
#endif /* AISendPackRouteProtocol_h */

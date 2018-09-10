//
//  AIShowSendPackRouteProtocol.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#ifndef AIShowSendPackRouteProtocol_h
#define AIShowSendPackRouteProtocol_h
#import <UIKit/UIKit.h>
@protocol AIShowSendPackRouteProtocol <NSObject>

- (void)presentSingleViewController:(UIViewController*)vc conversationId:(int64_t)conversationId;
-(void)presentGroupSendPackViewController:(UIWindow *)window conversationId:(int64_t)conversationId;
@end
#endif /* AIShowSendPackRouteProtocol_h */



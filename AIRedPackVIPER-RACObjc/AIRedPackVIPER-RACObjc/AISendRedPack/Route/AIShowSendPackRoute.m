//
//  AIShowSendPackRoute.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIShowSendPackRoute.h"
#import "AISingleSendPackViewController.h"
#import "AISendPackPresneter.h"
#import "AISendPackInteractor.h"
#import "AISendPackRoute.h"
#import "AIGroupSendPackViewController.h"
@implementation AIShowSendPackRoute
-(void)presentSingleViewController:(UIViewController *)vc conversationId:(int64_t)conversationId {
    AISingleSendPackViewController *view     = [[AISingleSendPackViewController alloc]init];
    AISendPackInteractor *interactor         = [[AISendPackInteractor alloc]initWithConversationId:conversationId];
    AISendPackPresneter *presenter           = [[AISendPackPresneter alloc]init];
    AISendPackRoute     *route               = [[AISendPackRoute alloc]init];
    presenter.view                           = view;
    presenter.interactor                     = interactor;
    presenter.route                          = route;
    view.presenter                           = presenter;
    
    UIWindow *window                         = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view];
    window.rootViewController   = nav;
    [window makeKeyAndVisible];
//    [vc presentViewController:nav animated:YES completion:nil];
}

-(void)presentGroupSendPackViewController:(UIWindow *)window conversationId:(int64_t)conversationId {
    AIGroupSendPackViewController *view      = [[AIGroupSendPackViewController alloc]init];
    AISendPackInteractor *interactor         = [[AISendPackInteractor alloc]initWithConversationId:conversationId];
    AISendPackPresneter *presenter           = [[AISendPackPresneter alloc]init];
    AISendPackRoute     *route               = [[AISendPackRoute alloc]init];
    presenter.view                           = view;
    presenter.interactor                     = interactor;
    presenter.route                          = route;
    view.presenter                           = presenter;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view];
    window.rootViewController   = nav;
    [window makeKeyAndVisible];

}
@end

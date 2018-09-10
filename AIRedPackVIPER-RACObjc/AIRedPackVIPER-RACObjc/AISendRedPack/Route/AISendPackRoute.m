//
//  AISendPackRoute.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISendPackRoute.h"
#import "AIBaseSendPackViewController.h"
@implementation AISendPackRoute

-(void)dismissFromVC:(UIViewController *)fromVC {
    [fromVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)pushToDetailVCFromVC:(UIViewController *)fromVC {
    //push到详情页面
//    TGTransactionDetailController *detail = [[TGTransactionDetailController alloc] initWithType:WalletOrderRedEnvelope];
//    [fromVC.navigationController pushViewController: detail animated:true];
}

- (void)pushToResetPasswordVCFromVC:(UIViewController*)fromVC {
//    TGWalletResetPassWordViewController *resetPassWordVC = [[TGWalletResetPassWordViewController alloc] init];
//    [fromVC.navigationController pushViewController:resetPassWordVC animated:YES];
}
- (void)pushToSettingPasswordVCFromVC:(UIViewController*)fromVC {
//    TGWalletPasswordSettingController *passwordSettingController = [[TGWalletPasswordSettingController alloc] initWithSetPasswordType:WALLETPASSWORD_FIRSTTIME_SET toManager:NO changeUI:NO];
//    passwordSettingController.complete = ^(BOOL success, __unused WalletPasswordSetting type) {
//        if (success) {
//            fromVC.isSetPayPassword = YES;
//        }
//    };
//    [fromVC.navigationController pushViewController:passwordSettingController animated:true];
}
@end

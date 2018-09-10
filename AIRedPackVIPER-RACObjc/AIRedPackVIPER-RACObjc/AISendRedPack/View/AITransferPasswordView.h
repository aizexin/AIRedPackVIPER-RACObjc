//
//  AITransferPasswordView.h
//  Tomato
//
//  Created by aizexin on 2018/6/11.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AITransferPassword_RedPacket = 1,
    AITransferPassword_TransferAccount,
    AITransferPassword_Unknow,
} AITransferPasswordType;

@class AITransferPasswordView;
@protocol AITransferPasswordViewDelegate <NSObject>

- (void)ai_transferPasswordViewOnClickCancel:(AITransferPasswordView*)passwordView;
- (void)ai_transferPasswordViewOnClickForget:(AITransferPasswordView*)passwordView;
@end

@interface AITransferPasswordView : UIView
/** 代理*/
@property(nonatomic,weak)id<AITransferPasswordViewDelegate> delegate;

@property (nonatomic) AITransferPasswordType type;
/** 钱*/
@property(nonatomic,copy)NSString *money;
/** 名字*/
@property(nonatomic,copy)NSString *name;
@property (nonatomic, copy) void (^paswodPrepareComplete) (NSDictionary *pasworInfo);

- (void)cleanPassword;


@end


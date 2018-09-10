//
//  AISendPackEntity.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import <Foundation/Foundation.h>
#import "AISendPackEnum.h"

@interface AISendPackEntity : NSObject

/** 红包个数*/
@property(nonatomic,copy)NSString *packNumber;
/** 总金额*/
@property(nonatomic,copy)NSString *totalMoney;
/** 单个金额*/
@property(nonatomic,copy)NSString *onePackMoney;
/** 祝福语*/
@property(nonatomic,copy)NSString *greetings;
/** 密码*/
@property(nonatomic,copy)NSString *password;
/**
 类型
 */
@property (assign, nonatomic)BOOL isRandom;
@property (assign, nonatomic)AISendPackType type;

@end

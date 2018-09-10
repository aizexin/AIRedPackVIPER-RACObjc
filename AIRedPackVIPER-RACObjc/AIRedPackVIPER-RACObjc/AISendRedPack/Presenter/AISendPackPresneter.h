//
//  AISendPackPresneter.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import <Foundation/Foundation.h>
#import "AISendPackPresenterProtocol.h"
#import "AISendPackRouteProtocol.h"
#import "AISendPackInteractorProtocol.h"
#import "AISendPackViewProtocol.h"
@interface AISendPackPresneter : NSObject <AISendPackPresenterProtocol>

@property (nonatomic,strong)id<AISendPackRouteProtocol> route;
/** 处理数据*/
@property(nonatomic,strong)id<AISendPackInteractorProtocol> interactor;
/** 视图*/
@property(nonatomic,weak)id<AISendPackViewProtocol> view;
@end

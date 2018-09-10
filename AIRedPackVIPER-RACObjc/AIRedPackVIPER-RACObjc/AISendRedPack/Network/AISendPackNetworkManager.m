//
//  AISendPackNetworkManager.m
//  Tomato
//
//  Created by aizexin on 2018/9/8.
//

#import "AISendPackNetworkManager.h"

@implementation AISendPackNetworkManager

+ (instancetype)shareManager {
    static AISendPackNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AISendPackNetworkManager alloc]init];
    });
    return manager;
}
@end

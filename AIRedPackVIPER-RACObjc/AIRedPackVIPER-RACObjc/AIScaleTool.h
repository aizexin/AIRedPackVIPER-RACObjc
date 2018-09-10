//
//  AIScaleTool.h
//  Share
//
//  Created by aizexin on 2018/6/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AIScaleTool : NSObject
CGFloat AIScale_x(CGFloat x);
CGFloat AIScale_y(CGFloat y);
/**
 计算安全区域
 */
+ (UIEdgeInsets)calculatedSafeAreaInsetWithController:(UIViewController *)contoller;
@end

//
//  AIScaleTool.m
//  Share
//
//  Created by aizexin on 2018/6/16.
//

#import "AIScaleTool.h"

@implementation AIScaleTool
/**
 计算安全区域
 */
+ (UIEdgeInsets)calculatedSafeAreaInsetWithController:(UIViewController *)contoller {
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
    if (contoller.view.frame.size.width > contoller.view.frame.size.height)
        orientation = UIInterfaceOrientationLandscapeLeft;
    
    return [AIScaleTool safeAreaInsetForOrientation:orientation];
}

bool AIIsPad()
{
    static bool value = false;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      value = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
                  });
    
    return value;
}

CGSize AIScreenSize()
{
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      UIScreen *screen = [UIScreen mainScreen];
                      
                      if ([screen respondsToSelector:@selector(fixedCoordinateSpace)])
                          size = [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace].size;
                      else
                          size = screen.bounds.size;
                  });
    
    return size;
}


+ (UIEdgeInsets)safeAreaInsetForOrientation:(UIInterfaceOrientation)orientation
{
    if (AIIsPad() || (int)AIScreenSize().height != 812)
        return UIEdgeInsetsZero;
    
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return UIEdgeInsetsMake(0.0f, 44.0f, 21.0f, 44.0f);
        default:
            return UIEdgeInsetsMake(44.0f, 0.0f, 34.0f, 0.0f);
    }
}

@end

CGFloat AIScale_x(CGFloat x) {
    CGFloat KWidth = AIScreenSize().width;
    return (x/375.0 * KWidth);
}
CGFloat AIScale_y(CGFloat y) {
    CGFloat KHeight = AIScreenSize().height;
    return (y/667.0 *KHeight);
}

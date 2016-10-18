//
//  UIView+ORGetController.h
//  OrangeDouYu
//
//  Created by orange on 16/9/11.
//  Copyright © 2016年 orange. All rights reserved.
//写完这个分类之后，就可以在需要获取控制器view中调用
//UIViewController *controller = [self viewController]; 得到的这个controller就是当前view所在的控制器。
//
//如果是在某个自定义view中，而这个view会被添加到某个viewController的view中，此时需要在这个自定义view的
//- (void)willMoveToSuperview:(UIView *)newSuperview
//在这个方法中调用[newSuperView viewController];就可以顺利拿到这个控制器了。

#import <UIKit/UIKit.h>

@interface UIView (ORGetController)
- (UIViewController *)viewController;
@end

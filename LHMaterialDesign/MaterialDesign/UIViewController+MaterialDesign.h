//
//  UIViewController+MaterialDesign.h
//  LHMaterialDesign
//
//  Created by lihao-xy on 15/3/27.
//  Copyright (c) 2015年 lihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MaterialDesign)

- (void)presentLHViewController:(UIViewController *)viewController
                           view:(UIView *)view
                          color:(UIColor *)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion;

- (void)dismissLHViewControllerWithColor:(UIColor*)color
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion;


@end

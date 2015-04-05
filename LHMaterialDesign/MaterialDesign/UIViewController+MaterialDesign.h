//
//  UIViewController+MaterialDesign.h
//  LHMaterialDesign
//
//  Created by lihao-xy on 15/3/27.
//  Copyright (c) 2015年 lihao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LHMDScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define LHMDScreenWidth     [[UIScreen mainScreen] bounds].size.width

@interface UIViewController (MaterialDesign)

/**
 *  Present View Controller with Material Design
 *
 *  @param viewController presented View Controller
 *  @param view           view tapped, to calculate the point that animation starts
 *  @param color          animation color, if nil, will use viewController's background color
 *  @param animated       animated or not
 *  @param completion     completion block
 */
- (void)presentLHViewController:(UIViewController *)viewController
                        tapView:(UIView *)view
                          color:(UIColor *)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion;

/**
 *  Dismiss View Controller with Material Design
 *
 *  @param view       view tapped, if nil, will use the presenting view controller's point that animation starts
 *  @param color      animation color, if nil, will use viewController's background color
 *  @param animated   animated or not
 *  @param completion completion block
 */
- (void)dismissLHViewControllerWithTapView:(UIView *)view
                                     color:(UIColor*)color
                                  animated:(BOOL)animated
                                completion:(void (^)(void))completion;

/**
 *  Push View Controller in UINavigationController with Material Design
 *
 *  @param viewController presented View Controller
 *  @param view           view tapped, to calculate the point that animation starts
 *  @param color          animation color, if nil, will use viewController's background color
 *  @param animated       animated or not
 *  @param completion     completion block
 */
- (void)pushLHViewController:(UIViewController *)viewController
                     tapView:(UIView *)view
                       color:(UIColor*)color
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

/**
 *  Pop View Controller in UINavigationController with Material Design
 *
 *  @param view       view tapped, if nil, will use the presenting view controller's point that animation starts
 *  @param color      animation color, if nil, will use viewController's background color
 *  @param animated   animated or not
 *  @param completion completion block
 */
- (void)popLHViewControllerWithTapView:(UIView *)view
                                 color:(UIColor*)color
                              animated:(BOOL)animated
                            completion:(void (^)(void))completion;

@end

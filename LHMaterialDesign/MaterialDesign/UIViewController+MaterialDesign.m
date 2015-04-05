//
//  UIViewController+MaterialDesign.m
//  LHMaterialDesign
//
//  Created by lihao-xy on 15/3/27.
//  Copyright (c) 2015年 lihao. All rights reserved.
//

#import "UIViewController+MaterialDesign.h"
#import <objc/runtime.h>

static const char *pointVarKey = "animationPoint";

@implementation UIViewController (MaterialDesign)

- (void)presentLHViewController:(UIViewController *)viewController
                        tapView:(UIView *)view
                          color:(UIColor*)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion{
    if (animated) {
        self.view.userInteractionEnabled = NO;
        CGPoint convertedPoint = [self.view convertPoint:view.center fromView:view.superview];
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController*)viewController).topViewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        } else {
            [viewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        }
        
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = viewController.view.backgroundColor;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:viewController animated:NO completion:nil];
        });
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:convertedPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        self.view.layer.masksToBounds = YES;
        [self.view.layer addSublayer:shapeLayer];
        
        [self mdAnimateAtPoint:convertedPoint duration:0.4 inflating:YES shapeLayer:shapeLayer completion:^{
            self.view.userInteractionEnabled = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        [self presentViewController:viewController animated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }
}

- (void)dismissLHViewControllerWithTapView:(UIView *)view
                                     color:(UIColor*)color
                                  animated:(BOOL)animated
                                completion:(void (^)(void))completion{
    if (animated) {
        CGPoint animaionPoint = CGPointZero;
        if (view) {
            animaionPoint = [self.view convertPoint:view.center fromView:view.superview];
        } else {
            animaionPoint = [[self animationPoint] CGPointValue];
        }
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = self.view.backgroundColor;
        }
        
        UIViewController *vc = self.presentingViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).topViewController;
        }
        vc.view.userInteractionEnabled = NO;
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:animaionPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        vc.view.layer.masksToBounds = YES;
        [vc.view.layer addSublayer:shapeLayer];
        
        [self dismissViewControllerAnimated:NO completion:^{
            [self mdAnimateAtPoint:animaionPoint duration:0.4 inflating:NO shapeLayer:shapeLayer completion:^{
                vc.view.userInteractionEnabled = YES;
                if (completion) {
                    completion();
                }
            }];
        }];
    } else {
        [self dismissViewControllerAnimated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }
}

- (void)pushLHViewController:(UIViewController *)viewController
                     tapView:(UIView *)view
                       color:(UIColor*)color
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion{
    if (animated) {
        self.view.userInteractionEnabled = NO;
        CGPoint convertedPoint = [self.view convertPoint:view.center fromView:view.superview];
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController*)viewController).topViewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        } else {
            [viewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        }
        
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = viewController.view.backgroundColor;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:viewController animated:NO];
        });
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:convertedPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        self.view.layer.masksToBounds = YES;
        [self.view.layer addSublayer:shapeLayer];
        
        [self mdAnimateAtPoint:convertedPoint duration:0.4 inflating:YES shapeLayer:shapeLayer completion:^{
            self.view.userInteractionEnabled = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        [self.navigationController pushViewController:viewController animated:NO];
        
        if (completion) {
            completion();
        }
    }
}

- (void)popLHViewControllerWithTapView:(UIView *)view
                                 color:(UIColor*)color
                              animated:(BOOL)animated
                            completion:(void (^)(void))completion{
    if (animated) {
        CGPoint animaionPoint = CGPointZero;
        if (view) {
            animaionPoint = [self.view convertPoint:view.center fromView:view.superview];
        } else {
            animaionPoint = [[self animationPoint] CGPointValue];
        }
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = self.view.backgroundColor;
        }
        
        if (self.navigationController.viewControllers.count < 2) {
            [self.navigationController popViewControllerAnimated:NO];
            return;
        }
        UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
        vc.view.userInteractionEnabled = NO;
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:animaionPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        vc.view.layer.masksToBounds = YES;
        [vc.view.layer addSublayer:shapeLayer];
        
        [self.navigationController popViewControllerAnimated:NO];
        [self mdAnimateAtPoint:animaionPoint duration:0.4 inflating:NO shapeLayer:shapeLayer completion:^{
            vc.view.userInteractionEnabled = YES;
            
            if (completion) {
                completion();
            }
        }];
    } else {
        [self.navigationController popViewControllerAnimated:NO];
        if (completion) {
            completion();
        }
    }
}

#pragma mark - animation

- (void)mdAnimateAtPoint:(CGPoint)point
                duration:(NSTimeInterval)duration
               inflating:(BOOL)inflating
              shapeLayer:(CAShapeLayer *)shapeLayer
              completion:(void (^)(void))block {
    
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [self shapeAnimationWithTimingFunction:[CAMediaTimingFunction functionWithName:timingFunctionName] scale:scale inflating:inflating];
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        if (block) {
            block();
        }
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
}

#pragma mark - helpers

- (CGFloat)mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = { {0.0, 0.0}, {0.0, LHMDScreenHeight}, {LHMDScreenWidth, LHMDScreenHeight}, {LHMDScreenWidth, 0.0} };
    CGFloat radius = 0.0;
    for (int i = 0; i < sizeof(cornerPoints) / sizeof(CGPoint); i++) {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0) );
        if (d > radius) {
            radius = d;
        }
    }
    return radius * 2.0;
}

- (CAShapeLayer *)mdShapeLayerForAnimationAtPoint:(CGPoint)point {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    return shapeLayer;
}

- (CABasicAnimation *)shapeAnimationWithTimingFunction:(CAMediaTimingFunction *)timingFunction scale:(CGFloat)scale inflating:(BOOL)inflating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    if (inflating) {
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    } else {
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    }
    animation.timingFunction = timingFunction;
    animation.removedOnCompletion = YES;
    return animation;
}

#pragma mark - var

- (NSValue *)animationPoint {
    return (NSValue *)objc_getAssociatedObject(self, &pointVarKey);
}

- (void)setAnimationPoint:(NSValue *)animationPoint {
    objc_setAssociatedObject(self, &pointVarKey, animationPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

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
                           view:(UIView *)view
                          color:(UIColor*)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion{
    self.view.userInteractionEnabled = NO;
    CGPoint convertedPoint = [self.view convertPoint:view.center fromView:view.superview];
    [viewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
    
    UIColor *animationColor = color;
    if (animationColor == nil) {
        animationColor = viewController.view.backgroundColor;
    }
    [self mdAnimateAtPoint:convertedPoint color:animationColor duration:0.5 inflating:YES presetingViewController:nil completion:^{
        self.view.userInteractionEnabled = YES;
        [self presentViewController:viewController animated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }];
}

- (void)dismissLHViewControllerWithColor:(UIColor*)color
                                animated:(BOOL)animated
                              completion:(void (^)(void))completion{
    CGPoint animaionPoint = [[self animationPoint] CGPointValue];
    UIColor *animationColor = color;
    if (animationColor == nil) {
        animationColor = self.view.backgroundColor;
    }
    
    UIViewController *vc = self.presentingViewController;
    vc.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:NO completion:^{
        [self mdAnimateAtPoint:animaionPoint color:animationColor duration:0.5 inflating:NO presetingViewController:vc completion:^{
            vc.view.userInteractionEnabled = YES;
            if (completion) {
                completion();
            }
        }];
    }];
}

#pragma mark - animation

- (void)mdAnimateAtPoint:(CGPoint)point color:(UIColor *)color duration:(NSTimeInterval)duration inflating:(BOOL)inflating presetingViewController:(UIViewController *)viewContrller completion:(void (^)(void))block {
    CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:point];
    shapeLayer.fillColor = color.CGColor;
    
    if (!inflating && viewContrller) {
        viewContrller.view.layer.masksToBounds = YES;
        [viewContrller.view.layer addSublayer:shapeLayer];
    } else {
        self.view.layer.masksToBounds = YES;
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // animate
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

/**
 *  求point点距离四个角的最大距离
 *
 *  @param point 动画扩散的中心点
 *
 *  @return 最大距离
 */
- (CGFloat)mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = { {0.0, 0.0}, {0.0, self.view.bounds.size.height}, {self.view.bounds.size.width, self.view.bounds.size.height}, {self.view.bounds.size.width, 0.0} };
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

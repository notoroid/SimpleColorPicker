//
//  IDPColorChangeTransition.m
//  ImageViewTest
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPColorChangeTransition.h"

@implementation IDPColorChangeTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    UIView *colorView = [[UIView alloc] initWithFrame:(CGRect){CGPointMake(fromView.frame.origin.x,fromView.frame.origin.y + fromView.frame.size.height),fromView.frame.size} ];
    colorView.backgroundColor = _color != nil ? _color : [UIColor blackColor];
    [containerView addSubview:colorView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] * .5f
         animations:^{
             colorView.frame = fromView.frame;
         }
         completion:^(BOOL finished){
             [fromView removeFromSuperview];
             
             [UIView animateWithDuration:[self transitionDuration:transitionContext] * .5f
                              animations:^{
                                  colorView.frame = (CGRect){CGPointMake(fromView.frame.origin.x,fromView.frame.origin.y - fromView.frame.size.height),fromView.frame.size};
                              }
                              completion:^(BOOL finished){
                                  [colorView removeFromSuperview];
                                  
                                  BOOL completed = [transitionContext transitionWasCancelled] ? NO : YES;
                                  [transitionContext completeTransition:completed];
                              }
              ];
         }
     ];
}


@end

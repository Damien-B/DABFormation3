//
//  VerticalDoorOpenAnimator.m
//  DABFormation3
//
//  Created by mac mini pprod 3 on 10/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "VerticalDoorOpenAnimator.h"

@implementation VerticalDoorOpenAnimator


- (id)initAnimatorWithType:(NSString *)type andDuration:(float)duration {
    self.duration = duration;
    self.transitionAnimationType = type; // present or dismiss
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if([self.transitionAnimationType isEqualToString:@"present"]){// presenting transition
        UIViewController* toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView* container = [transitionContext containerView];
        
        //get rects that represent the top and bottom halves of the screen
        CGSize viewSize = fromController.view.bounds.size;
        CGRect topFrame = CGRectMake(0, 0, viewSize.width, viewSize.height/2);
        CGRect bottomFrame = CGRectMake(0, viewSize.height/2, viewSize.width, viewSize.height/2);
        
        //create snapshots
        UIView* snapshot = [fromController.view snapshotViewAfterScreenUpdates:YES];
        UIView* snapshotDestination = [toController.view snapshotViewAfterScreenUpdates:YES];
        UIView* snapshotTop = [snapshot resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        UIView* snapshotBottom = [snapshot resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        //start the frames with an offset
        snapshotTop.frame = topFrame;
        snapshotBottom.frame = bottomFrame;
        
        //add our snapshots on top
        [container addSubview:snapshotDestination];
        [container addSubview:snapshotTop];
        [container addSubview:snapshotBottom];
        
        
        // tried to use beizer curve
        // [CAMediaTimingFunction functionWithControlPoints:.92 :1.78 :.98 :.5]
        
        //[UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:self.duration animations:^{
                //set the frames to animate them back into place
                CGRect offsetTopFrame = topFrame;
                CGRect offsetBottomFrame = bottomFrame;
                offsetTopFrame.origin.y -= topFrame.size.height;
                offsetBottomFrame.origin.y += bottomFrame.size.height;
                snapshotTop.frame = offsetTopFrame;
                snapshotBottom.frame = offsetBottomFrame;
            }];
            
        } completion:^(BOOL finished){
            
            //don't forget to clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            [fromController.view removeFromSuperview];
            [snapshotDestination removeFromSuperview];
            [container addSubview:toController.view];
            
            [transitionContext completeTransition:finished];
        }];
    }else if([self.transitionAnimationType isEqualToString:@"dismiss"]){// dismissing transition
        UIViewController* toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView* container = [transitionContext containerView];
        
        //get rects that represent the top and bottom halves of the screen
        CGSize viewSize = fromController.view.bounds.size;
        CGRect topFrame = CGRectMake(0, 0, viewSize.width, viewSize.height/2);
        CGRect bottomFrame = CGRectMake(0, viewSize.height/2, viewSize.width, viewSize.height/2);
        
        //create snapshots
        UIView* snapshot = [toController.view snapshotViewAfterScreenUpdates:YES];
        UIView* snapshotTop = [snapshot resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        UIView* snapshotBottom = [snapshot resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        //start the frames with an offset
        CGRect offsetTopFrame = topFrame;
        CGRect offsetBottomFrame = bottomFrame;
        offsetTopFrame.origin.y -= topFrame.size.height;
        offsetBottomFrame.origin.y += bottomFrame.size.height;
        snapshotTop.frame = offsetTopFrame;
        snapshotBottom.frame = offsetBottomFrame;
        
        //add our snapshots on top
        [container addSubview:snapshotTop];
        [container addSubview:snapshotBottom];
        
//        [UIView animateWithDuration:self.duration animations:^{
         [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:self.duration animations:^{
                //set the frames to animate them back into place
                snapshotTop.frame = topFrame;
                snapshotBottom.frame = bottomFrame;
            }];
            
        } completion:^(BOOL finished){
            NSLog(@"testestestestest");
            //don't forget to clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            [fromController.view removeFromSuperview];
//            fromController.view.hidden = YES;
            [container addSubview:toController.view];
            
            // in case gesture transition is cancelled
            // replace this :
            // [transitionContext completeTransition:finished];
            // by this :
            if(transitionContext.transitionWasCancelled)
            {
                [toController.view removeFromSuperview];
                [container addSubview:fromController.view];
            }
            
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }else if([self.transitionAnimationType isEqualToString:@"blur"]){
        
        
        
        UIViewController* toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView* container = [transitionContext containerView];
        
        //get rects that represent the top and bottom halves of the screen
        CGSize viewSize = fromController.view.bounds.size;
        CGRect fullFrame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        
        //create snapshots
        UIView* snapshot = [fromController.view snapshotViewAfterScreenUpdates:YES];
        UIView* snapshotDestination = [toController.view snapshotViewAfterScreenUpdates:YES];
        
        //start the frames with an offset
        snapshot.frame = fullFrame;
        snapshotDestination.frame = fullFrame;
        snapshotDestination.layer.opacity = 0.0;
        [container addSubview:snapshotDestination];
        
//        UIVisualEffect *blurEffect;
//        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *visualEffectView;
//        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        visualEffectView.frame = snapshot.bounds;
//        [snapshotDestination addSubview:visualEffectView];

        
        
        [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:self.duration/2 animations:^{
                
                snapshotDestination.layer.opacity = 1.0;
            }];
            [UIView addKeyframeWithRelativeStartTime:self.duration/2 relativeDuration:self.duration/2 animations:^{
                
            }];
            
        } completion:^(BOOL finished){
            
            //don't forget to clean up
            [snapshot removeFromSuperview];
            [fromController.view removeFromSuperview];
            [snapshotDestination removeFromSuperview];
            [container addSubview:toController.view];
            
            [transitionContext completeTransition:finished];
        }];
        
        
    }
}
@end

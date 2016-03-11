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
        
        // [CAMediaTimingFunction functionWithControlPoints:.92 :1.78 :.98 :.5]
        [UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            //set the frames to animate them back into place
            CGRect offsetTopFrame = topFrame;
            CGRect offsetBottomFrame = bottomFrame;
            offsetTopFrame.origin.y -= topFrame.size.height;
            offsetBottomFrame.origin.y += bottomFrame.size.height;
            snapshotTop.frame = offsetTopFrame;
            snapshotBottom.frame = offsetBottomFrame;
            
        } completion:^(BOOL finished){
            
            //don't forget to clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            [fromController.view removeFromSuperview];
            [snapshotDestination removeFromSuperview];
            [container addSubview:toController.view];
            
            [transitionContext completeTransition:finished];
        }];
    }else{// dismissing transition
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
        
        [UIView animateWithDuration:self.duration animations:^{
            
            //set the frames to animate them back into place
            snapshotTop.frame = topFrame;
            snapshotBottom.frame = bottomFrame;
            
        } completion:^(BOOL finished){
            
            //don't forget to clean up
            [snapshotTop removeFromSuperview];
            [snapshotBottom removeFromSuperview];
            [fromController.view removeFromSuperview];
            [container addSubview:toController.view];
            
            [transitionContext completeTransition:finished];
        }];
    }
}
@end

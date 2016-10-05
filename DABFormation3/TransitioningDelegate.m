//
//  TransitioningDelegate.m
//  DABFormation3
//
//  Created by mac mini pprod 3 on 10/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "TransitioningDelegate.h"
#import "ViewController.h"
#import "VerticalDoorOpenAnimator.h"
#import "FirstViewController.h"

@implementation TransitioningDelegate

#pragma mark - UINavigationController delegate



- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if([fromVC isMemberOfClass:[ViewController class]] && [toVC isMemberOfClass:[FirstViewController class]]){
        return [[VerticalDoorOpenAnimator alloc] initAnimatorWithType:@"present" andDuration:0.45];
    } else if([toVC isMemberOfClass:[ViewController class]] && [fromVC isMemberOfClass:[FirstViewController class]]){
        self.transition = ((FirstViewController *)fromVC).transition;
        return [[VerticalDoorOpenAnimator alloc] initAnimatorWithType:@"dismiss" andDuration:0.45];
    } else {
        return [[VerticalDoorOpenAnimator alloc] initAnimatorWithType:@"blur" andDuration:2.45];
    }
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if([animationController isKindOfClass:[VerticalDoorOpenAnimator class]])
        NSLog(@"%@", [[navigationController viewControllers] lastObject]);
        NSLog(@"%@", self.transition);
        if([[[navigationController viewControllers] lastObject] isMemberOfClass:[ViewController class]]){
            NSLog(@"self.transition : %@", self.transition);
            //this line make click on back button crash ( skype
            //return self.transition;//((FirstViewController *)[[navigationController viewControllers] lastObject]).transition;
        }
    return nil;
}

@end

//
//  VerticalDoorOpenAnimator.h
//  DABFormation3
//
//  Created by mac mini pprod 3 on 10/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VerticalDoorOpenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property float duration;
@property NSString *transitionAnimationType;


- (id)initAnimatorWithType:(NSString *)type andDuration:(float)duration;

@end

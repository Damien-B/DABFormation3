//
//  FirstViewController.m
//  DABFormation3
//
//  Created by mac mini pprod 3 on 08/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "FirstViewController.h"
#import "VerticalDoorOpenAnimator.h"
#import "TransitioningDelegate.h"
#import "ViewController.h"

@interface FirstViewController ()

//@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *transition;
@property TransitioningDelegate *transitioningDelegate;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer* pinch;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transition = [[UIPercentDrivenInteractiveTransition alloc] init];
//    self.transitioningDelegate = [[TransitioningDelegate alloc] init];
//    self.navigationController.delegate = self.transitioningDelegate;
    // Do any additional setup after loading the view.
    self.pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:_pinch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)percentForPinch:(UIPinchGestureRecognizer*)pinch {
    return (1.0f - pinch.scale)/2.0f;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            if(sender.velocity > 0.0f)
                return;
            [self performSegueWithIdentifier:@"unwindSegueFromFirstVCToVC" sender:sender];
            break;
        case UIGestureRecognizerStateChanged:
            [_transition updateInteractiveTransition:[self percentForPinch:sender]];
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
            if([self percentForPinch:sender] < 0.25f){
                [_transition cancelInteractiveTransition];
            }else{
                [_transition finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

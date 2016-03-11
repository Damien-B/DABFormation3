//
//  ViewController.m
//  DABFormation3
//
//  Created by mac mini pprod 3 on 08/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "ViewController.h"
#import "TransitioningDelegate.h"

@interface ViewController ()

@property TransitioningDelegate *transitioningDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = [[TransitioningDelegate alloc] init];
    self.navigationController.delegate = self.transitioningDelegate;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstVCUnwindAction:(UIStoryboardSegue*)unwindSegue {
    NSLog(@"unwind segue from first VC");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}



@end

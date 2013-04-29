//
//  ORViewController.m
//  KeyboardTest
//
//  Created by orta therox on 08/04/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORViewController.h"
#import "ORKeyboardReactingApplication.h"

@implementation ORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"a" :^{
        NSLog(@"A WAS CALLED");
    }];


    [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"A" :^{
        NSLog(@"Oh HI THER CAPS A");
    }];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


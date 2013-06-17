//
//  ORViewController.m
//  KeyboardTest
//
//  Created by orta therox on 08/04/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORViewController.h"
#import "ORKeyboardReactingApplication.h"

@interface ORViewController ()
@property (weak, nonatomic) IBOutlet UIView *aView;
@property (weak, nonatomic) IBOutlet UIView *sView;
@property (weak, nonatomic) IBOutlet UIView *dView;
@end

@implementation ORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak ORViewController *this = self;
    [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"a" :^{
        [this toggleColourOnView:this.aView];
    }];

    [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"s" :^{
        [this toggleColourOnView:this.sView];
    }];

    [ORKeyboardReactingApplication registerForSelectorOnKeyDown:@"d" target:self action:@selector(switchDColours)];
}

- (void)switchDColours {
    [self toggleColourOnView:self.dView];
}

- (void)toggleColourOnView:(UIView *)view {
    if (view.tag) {
        view.backgroundColor = [UIColor colorWithRed:0.511 green:0.535 blue:1.000 alpha:1.000];
        view.tag = 0;
    } else {
        view.backgroundColor = [UIColor colorWithRed:0.416 green:0.043 blue:0.757 alpha:1.000];
        view.tag = 1;
    }

}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAView:nil];
    [self setSView:nil];
    [self setDView:nil];
    [super viewDidUnload];
}
@end


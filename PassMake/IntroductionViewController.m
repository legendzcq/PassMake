//
//  IntroductionViewController.m
//  Message
//
//  Created by 普科 on 13-8-18.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "IntroductionViewController.h"
#import "AppDelegate.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

-(void)backM:(id)sender
{
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)now.dengLuViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

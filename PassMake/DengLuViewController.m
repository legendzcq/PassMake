//
//  DengLuViewController.m
//  Message
//
//  Created by 普科 on 13-8-18.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "DengLuViewController.h"
#import "MyPass.h"
#import "AppDelegate.h"
#import "LoginInfo.h"

@interface DengLuViewController ()

@end

@implementation DengLuViewController

-(void)noLogin:(id)sender
{
    AppDelegate *now = [[UIApplication sharedApplication] delegate];
    [LoginInfo setIsCloud:NO];
    [LoginInfo setIslogin:NO];
    now.window.rootViewController = (UIViewController *)now.makePassViewController;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(void)help:(id)sender
{
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)now.introductionViewController;
}

-(void)zhuce:(id)sender
{
    AppDelegate *now = [[UIApplication sharedApplication] delegate];
    now.window.rootViewController = (UIViewController *)now.reViewController;
}

-(void)login:(id)sender
{
    if (self.userName.text.length < 6 || self.passWord.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"!!!" message:@"用户名或密码少于6位" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    MyPass *pass = [MyPass shared];
    [pass selectUser:self.userName.text andPass:self.passWord.text];
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

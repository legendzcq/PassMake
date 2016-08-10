//
//  SaveViewController.m
//  Re
//
//  Created by hiroshika on 13-8-19.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import "SaveViewController.h"
#import "AppDelegate.h"
#import "LoginInfo.h"
#import "PassDao.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

NSString *hehe;

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return 1;
}

-(void)saveB:(id)sender
{
    
    if ([self.mima.text isEqualToString:@""] || [self.passname.text isEqualToString:@""]) {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"请完善内容" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
        return;
    }
    
    if ([LoginInfo isCloud]) {
     
        [self.mpass insertPass:self.mima.text andTitle:self.passname.text andUserId:[LoginInfo _id]];
        
    }else
    {
        PassInfo *info = [[PassInfo alloc] init];
        info.title = self.passname.text;
        info.pass = self.mima.text;
        BOOL hehe = [[PassDao shared] addPass:info];
        if (hehe) {
            [[[[UIAlertView alloc] initWithTitle:@"" message:@"添加成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
        }else
        {
            [[[[UIAlertView alloc] initWithTitle:@"" message:@"添加失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
        }
        [info release];
        [self backMake:nil];
    }
}

-(void)backMake:(id)sender
{
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    [now.window.rootViewController release];
    now.window.rootViewController = (UIViewController *)now.makePassViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mpass = [[MyPass alloc]init];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPass:(NSString *)pass
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        hehe = pass;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mima.text = hehe;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

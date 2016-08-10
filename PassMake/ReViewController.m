//
//  ReViewController.m
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import "ReViewController.h"
#import "AppDelegate.h"

@interface ReViewController ()

@end

//@property (strong,nonatomic) IBOutlet UITextField * name;//用户名
//@property (strong,nonatomic) IBOutlet UITextField * sex;//性别
//@property (strong,nonatomic) IBOutlet UITextField * pass;//密码
//@property (strong,nonatomic) IBOutlet UITextField * confrim;//确认密码
//@property (strong,nonatomic) IBOutlet UIButton *reg;//注册
//@property (strong,nonatomic) IBOutlet UIButton *reset;//重置

@implementation ReViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return 1;
}

-(void)zhuce:(id)sender
{
    if ([self.name.text isEqualToString:@""] || [self.pass.text isEqualToString:@""] || [self.confrim.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"!!!" message:@"信息不完整" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    if (self.name.text.length <6 ||self.pass.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"!!!" message:@"用户名或密码少于6位" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    if (![self.pass.text isEqualToString:self.confrim.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"!!!" message:@"两次输入的密码不同" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        NSLog(@"%@",[self.sex titleForSegmentAtIndex:[self.sex selectedSegmentIndex]]);
        [self.mpass insertUser:self.name.text andPass:self.pass.text andSex:([self.sex selectedSegmentIndex] ==1 ? @"女":@"男")];
    }
}
-(void)rese:(id)sender
{
    self.name.text = @"";
    self.confrim.text = @"";
    self.pass.text = @"";
}

-(void)backM:(id)sender
{
    AppDelegate *now = [[UIApplication sharedApplication] delegate];
    now.window.rootViewController = (UIViewController *)now.dengLuViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mpass = [[MyPass alloc] init];
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

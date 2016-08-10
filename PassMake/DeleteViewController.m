//
//  DeleteViewController.m
//  pass
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "DeleteViewController.h"
#import "MyPass.h"
#import "AppDelegate.h"
#import "LoginInfo.h"
#import "PassViewController.h"
#import "PassDao.h"

@interface DeleteViewController ()

@end

@implementation DeleteViewController

-(void)backM:(id)sender
{
    if ([LoginInfo isCloud]) {
        [[MyPass shared] selectPass:[LoginInfo _id]];
        [self release];
    }else
    {
        [LoginInfo setIsCloud:NO];
        AppDelegate *now = [UIApplication sharedApplication].delegate;
        now.window.rootViewController = (UIViewController *)[[PassViewController alloc] initWithNibName:@"PassViewController" bundle:nil andArr:[[PassDao shared] selectAllP]];
    }
}

-(void)delPass:(id)sender
{
    if ([LoginInfo isCloud]) {
        [[MyPass shared] deletePass:self.pass._id];
    }else
    {
        BOOL hehe = [[PassDao shared] doDelete:[self.pass _id]];
        if (hehe) {
            [[[[UIAlertView alloc] initWithTitle:@"" message:@"删除成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
        }

    }
[self backM:nil];

}
-(IBAction)fuzhi:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.Password.text;
    [[[UIAlertView alloc] initWithTitle:@"" message:@"已经将密码复制" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andInfo:(PassInfo *)pass
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.pass = pass;
        NSLog(@"%@",pass);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad");
    self.passwordName.text = self.pass.title;
    self.Password.text = self.pass.pass;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

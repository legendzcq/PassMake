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
#import "PassInfo.h"
#import "CameraSessionView.h"
#import "LKDBTool.h"
@interface DeleteViewController ()<CACameraSessionDelegate>

@end

@implementation DeleteViewController

-(void)backM:(id)sender
{
    if ([LoginInfo isCloud]) {
        [[MyPass shared] selectPass:[LoginInfo _id]];
    }else
    {
        [LoginInfo setIsCloud:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)delPass:(id)sender
{
    if ([LoginInfo isCloud]) {
        [[MyPass shared] deletePass:self.pass._id];
    }else
    {
        LKDBSQLState *sql = [[LKDBSQLState alloc] object:[PassInfo class] type:WHERE key:@"title" opt:@"=" value:self.pass.title];
        
       BOOL hehe =  [PassInfo deleteObjectsWithFormat:[sql sqlOptionStr]];
        if (hehe) {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"删除成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }

    }
[self backM:nil];

}
-(IBAction)fuzhi:(id)sender
{
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.Password.text;
//    [[[UIAlertView alloc] initWithTitle:@"" message:@"已经将密码复制" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    UIImage * image =   [[UIImage alloc]initWithData:self.pass.imageData];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"图片导出失败" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    else
     [[[UIAlertView alloc] initWithTitle:@"Yes!" message:@"图片导出成功" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
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
    self.imageCore.image =[[UIImage alloc]initWithData:self.pass.imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

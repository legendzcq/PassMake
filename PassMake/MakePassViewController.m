//
//  MakePassViewController.m
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import "MakePassViewController.h"
#import "SaveViewController.h"
#import "AppDelegate.h"
#import "LoginInfo.h"
#import "PassViewController.h"
#import "PassDao.h"

@interface MakePassViewController ()

@end

@implementation MakePassViewController

//@property (strong,nonatomic)IBOutlet UITextField * length;//密码长度
//@property (strong,nonatomic)IBOutlet UISwitch *number;//选择数字
//@property (strong,nonatomic)IBOutlet UISwitch *capital;//使用大写
//@property (strong,nonatomic)IBOutlet UISwitch *lower;//使用小写
//@property (strong,nonatomic)IBOutlet UISwitch *special;//使用特殊字符
//@property (strong,nonatomic)IBOutlet UITextField *gengrate;//生成密码
//@property (strong,nonatomic)IBOutlet UIButton *cloud;//保存云端
//@property (strong,nonatomic)IBOutlet UIButton *save;//保存
//@property (strong,nonatomic)IBOutlet UIButton *look;//进行查看

-(void)findMiMa:(id)sender
{
    if ([LoginInfo islogin]) {
        [LoginInfo setIsCloud:YES];
        [self.pass selectPass:[LoginInfo _id]];
    }else
    {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"您还木有登陆" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]autorelease]show];
    }
}


-(void)makePass:(id)sender
{
    if ([self.length.text isEqualToString:@"" ]|| self.length.text.intValue <= 0 || self.length.text.intValue > 16) {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"请输入一个大于0小于16的长度" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]autorelease]show];
        return;
    }
    int length = self.length.text.intValue;
    BOOL number = self.number.isOn;
    BOOL capital = self.capital.isOn;
    BOOL lower = self.lower.isOn;
    BOOL special = self.special.isOn;
    
    self.gengrate.text = [self.pass passMakeLenth:length andHaveUp:capital andHaveLow:lower andHaveTeShu:special andHaveNumBer:number];
    [self fuzhi];
}

-(void)fuzhi
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.gengrate.text;
    [[[UIAlertView alloc] initWithTitle:@"" message:@"已经将密码复制" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

-(void)bendiM:(id)sender
{
    [LoginInfo setIsCloud:NO];
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)[[PassViewController alloc] initWithNibName:@"PassViewController" bundle:nil andArr:[[PassDao shared] selectAllP]];
}

-(void)saveBenDi:(id)sender
{
    if ([self.gengrate.text isEqualToString:@""]) {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"请先生成密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]autorelease]show];
        return;
    }
    [LoginInfo setIsCloud:NO];
    SaveViewController *con = [[SaveViewController alloc] initWithNibName:@"SaveViewController" bundle:nil andPass:self.gengrate.text];
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)con;
}

-(void)saveCloud:(id)sender
{
    if ([self.gengrate.text isEqualToString:@""]) {
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"请先生成密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]autorelease]show];
        return;
    }
    if ([LoginInfo islogin]) {
        [LoginInfo setIsCloud:YES];
        SaveViewController *con = [[SaveViewController alloc] initWithNibName:@"SaveViewController" bundle:nil andPass:self.gengrate.text];
        AppDelegate *now = [UIApplication sharedApplication].delegate;
        now.window.rootViewController = (UIViewController *)con;
        
    }else{
        [[[[UIAlertView alloc] initWithTitle:@"" message:@"您还木有登陆" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]autorelease]show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return 1;
}

-(void)logoutM:(id)sender
{
    [LoginInfo setName:@"游客"];
    [LoginInfo setSex:@"男"];
    [LoginInfo setIslogin:NO];
    [LoginInfo setIsCloud:NO];
    [LoginInfo setId:0];
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)now.dengLuViewController;
}

- (void)dealloc
{
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.pass = [[MyPass alloc] init];
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

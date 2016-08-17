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
#import "CameraSessionView.h"
#import "saveImageController.h"
#import "PassInfo.h"
@interface MakePassViewController ()<CACameraSessionDelegate>
@property (nonatomic, strong) CameraSessionView *cameraView;
@end

@implementation MakePassViewController

-(void)findMiMa:(id)sender
{
    if ([LoginInfo islogin]) {
        [LoginInfo setIsCloud:YES];
        [self.pass selectPass:[LoginInfo _id]];
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"您还木有登陆" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}


-(void)makePass:(id)sender
{
    if ([self.length.text isEqualToString:@"" ]|| self.length.text.intValue <= 0 || self.length.text.intValue > 16) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"请输入一个大于0小于16的长度" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
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

       PassViewController * tempcon =  (PassViewController *)[[PassViewController alloc] initWithNibName:@"PassViewController" bundle:nil andArr:(NSMutableArray *)[PassInfo findAll]];
    [self.navigationController pushViewController:tempcon animated:YES];
}

-(void)saveBenDi:(id)sender
{
    if ([self.gengrate.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"请先生成密码" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return;
    }
    [LoginInfo setIsCloud:NO];
    SaveViewController *con = [[SaveViewController alloc] initWithNibName:@"SaveViewController" bundle:nil andPass:self.gengrate.text];
    [self.navigationController pushViewController:con animated:YES];
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
    self.navigationItem.title = @"极密宝demo";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 拍照
-(void)saveCloud:(id)sender
{
    //Set white status bar
    [self setNeedsStatusBarAppearanceUpdate];
//    [self.navigationController setNavigationBarHidden:YES];
    
    //Instantiate the camera view & assign its frame
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    
    //Set the camera view's delegate and add it as a subview
    _cameraView.delegate = self;
    
    //Apply animation effect to present the camera view
//    CATransition *applicationLoadViewIn =[CATransition animation];
//    [applicationLoadViewIn setDuration:0.6];
//    [applicationLoadViewIn setType:kCATransitionReveal];
//    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//    [[_cameraView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
//    
//    [self.view addSubview:_cameraView];
//    
//    //____________________________Example Customization____________________________
//        [_cameraView setTopBarColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha: 0.64]];
//        [_cameraView hideFlashButton]; //On iPad flash is not present, hence it wont appear.
//        [_cameraView hideCameraToggleButton];
//        [_cameraView hideDismissButton];
    
    
    saveImageController * save = [[saveImageController alloc] init];
    
    save.imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"123"], 1.0);
    [self.navigationController pushViewController:save animated:YES];
    
}

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    [self.cameraView removeFromSuperview];
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //    UIImage *image = [[UIImage alloc] initWithData:imageData];
    //    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [self.cameraView removeFromSuperview];
        saveImageController * save = [[saveImageController alloc] init];
    
        save.imageData = imageData;
        [self.navigationController pushViewController:save animated:YES];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

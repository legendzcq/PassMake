//
//  saveImageController.m
//  PassMake
//
//  Created by 张传奇 on 16/8/11.
//  Copyright © 2016年 普科. All rights reserved.
//

#import "saveImageController.h"
#import "PassInfo.h"
@implementation saveImageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"图片保存";
    
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initUI];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)saveBtn
{
    if (self.nameF.text.length == 0) {
    [[[UIAlertView alloc] initWithTitle:@"" message:@"名字不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    PassInfo *info = [[PassInfo alloc] init];
    info.title = self.nameF.text;
    info.imageData =self.imageData;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        BOOL hehe = [info save];
//        if (hehe) {
//            [[[UIAlertView alloc] initWithTitle:@"" message:@"添加成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//        }else
//        {
//            [[[UIAlertView alloc] initWithTitle:@"" message:@"添加失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//        }
    });

}

-(void)initUI
{
    UILabel * nameL = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 70, 30)];
    nameL.text = @"姓名:";
    [self.view addSubview:nameL];
    
    UITextField * nameF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameL.frame)+5, 70, 150, 30)];
    nameF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameF];
    self.nameF = nameF;
    
    
    UIImageView *imageCore = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(nameF.frame)+10, 250, 300)];
    [self.view addSubview:imageCore];
    self.imageCore = imageCore;
    self.imageCore.image =[[UIImage alloc]initWithData:self.imageData];

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageCore.frame)+10, 100, 30)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

@end

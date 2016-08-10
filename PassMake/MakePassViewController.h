//
//  MakePassViewController.h
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPass.h"

@interface MakePassViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic)IBOutlet UITextField * length;//密码长度
@property (strong,nonatomic)IBOutlet UISwitch *number;//选择数字
@property (strong,nonatomic)IBOutlet UISwitch *capital;//使用大写
@property (strong,nonatomic)IBOutlet UISwitch *lower;//使用小写
@property (strong,nonatomic)IBOutlet UISwitch *special;//使用特殊字符
@property (strong,nonatomic)IBOutlet UITextField *gengrate;//生成密码
@property (strong,nonatomic)IBOutlet UIButton *cloud;//保存云端
@property (strong,nonatomic)IBOutlet UIButton *save;//保存
@property (strong,nonatomic)IBOutlet UIButton *look;//进行查看
@property (strong,nonatomic)IBOutlet UIButton *find;//进行查看
@property (strong,nonatomic)IBOutlet UIButton *bendi;
@property (strong,nonatomic)IBOutlet UIButton *logout;
@property (strong,nonatomic)MyPass *pass;

-(IBAction)makePass:(id)sender;
-(IBAction)saveCloud:(id)sender;
-(IBAction)findMiMa:(id)sender;
-(IBAction)bendiM:(id)sender;
-(IBAction)saveBenDi:(id)sender;
-(IBAction)logoutM:(id)sender;

@end

//
//  SaveViewController.h
//  Re
//
//  Created by hiroshika on 13-8-19.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPass.h"

@interface SaveViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic)IBOutlet UIButton *back;//返回
@property (strong,nonatomic)IBOutlet UITextField *passname;//密码名称
@property (strong,nonatomic)IBOutlet UITextField *mima;//生成显示密码
@property (strong,nonatomic)IBOutlet UIButton *save;//保存
@property (strong,nonatomic)MyPass *mpass;
@property (weak, nonatomic) IBOutlet UIImageView *saveimage;//图片

-(IBAction)backMake:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPass:(NSString *)pass;

-(IBAction)saveB:(id)sender;

@end

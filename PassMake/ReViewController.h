//
//  ReViewController.h
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPass.h"

@interface ReViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic) IBOutlet UITextField * name;//用户名
@property (strong,nonatomic) IBOutlet UISegmentedControl * sex;//性别
@property (strong,nonatomic) IBOutlet UITextField * pass;//密码
@property (strong,nonatomic) IBOutlet UITextField * confrim;//确认密码
@property (strong,nonatomic) IBOutlet UIButton *reg;//注册
@property (strong,nonatomic) IBOutlet UIButton *reset;//重置
@property (strong,nonatomic) IBOutlet UIButton *back;
@property (strong,nonatomic) MyPass *mpass;

-(IBAction)rese:(id)sender;
-(IBAction)zhuce:(id)sender;
-(IBAction)backM:(id)sender;


@end

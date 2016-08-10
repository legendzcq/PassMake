//
//  DengLuViewController.h
//  Message
//
//  Created by 普科 on 13-8-18.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DengLuViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic) IBOutlet UITextField * userName;
@property(strong,nonatomic) IBOutlet UITextField * passWord;
@property(strong,nonatomic) IBOutlet UIButton * userRegistration;
@property(strong,nonatomic) IBOutlet UIButton * introduction;
@property(strong,nonatomic) IBOutlet UIButton * userLogin;
@property(strong,nonatomic) IBOutlet UIButton * visitorLogin;

-(IBAction)login:(id)sender;
-(IBAction)zhuce:(id)sender;
-(IBAction)help:(id)sender;
-(IBAction)noLogin:(id)sender;

@end

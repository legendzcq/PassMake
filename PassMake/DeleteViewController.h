//
//  DeleteViewController.h
//  pass
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassInfo.h"

@interface DeleteViewController : UIViewController
@property(strong,nonatomic)IBOutlet UILabel * passwordName;
@property(strong,nonatomic)IBOutlet UILabel * Password;
@property(strong,nonatomic)IBOutlet UIButton * del;
@property (strong,nonatomic)IBOutlet UIButton *back;
@property (strong,nonatomic)PassInfo *pass;
@property(strong,nonatomic)IBOutlet UIButton *cop;


-(IBAction)delPass:(id)sender;
-(IBAction)backM:(id)sender;
-(IBAction)fuzhi:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andInfo:(PassInfo *)pass;

@end

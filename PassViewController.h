//
//  PassViewController.h
//  PassMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong) IBOutlet UITableView *tv;
@property (nonatomic,strong)IBOutlet UIButton *back;
@property (nonatomic,strong)IBOutlet UILabel *info;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArr:(NSMutableArray *)arr;
-(IBAction)backH:(id)sender;

@end

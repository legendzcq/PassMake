//
//  PassViewController.m
//  PassMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "PassViewController.h"
#import "PassInfo.h"
#import "AppDelegate.h"
#import "LoginInfo.h"
#import "DeleteViewController.h"

@interface PassViewController ()

@end

@implementation PassViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArr:(NSMutableArray *)arr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arr = arr;
        
    }
    return self;
}

-(void)backH:(id)sender
{
    AppDelegate *now = [UIApplication sharedApplication].delegate;
    now.window.rootViewController = (UIViewController *)now.makePassViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //; Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    PassInfo *info = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.text = info.title;
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeleteViewController *now =[[DeleteViewController alloc] initWithNibName:@"DeleteViewController" bundle:nil andInfo:[self.arr objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:now animated:YES];
}

@end

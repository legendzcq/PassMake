//
//  saveImageController.h
//  PassMake
//
//  Created by 张传奇 on 16/8/11.
//  Copyright © 2016年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface saveImageController : UIViewController
@property(nonatomic)NSData * imageData;
@property (weak, nonatomic)  UIImageView *imageCore;
@property (weak, nonatomic)  UITextField * nameF;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end

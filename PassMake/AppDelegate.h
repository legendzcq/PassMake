//
//  AppDelegate.h
//  PassMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class DengLuViewController;
@class MakePassViewController;
@class ReViewController;
@class IntroductionViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) DengLuViewController *dengLuViewController;
@property (strong,nonatomic) MakePassViewController *makePassViewController;
@property (strong,nonatomic)ReViewController *reViewController;
@property (strong,nonatomic)IntroductionViewController *introductionViewController;

@end

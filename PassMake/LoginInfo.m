//
//  LoginInfo.m
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import "LoginInfo.h"
static BOOL islogin = NO;
static NSString *name = @"游客";
static NSString *sex = @"男";
static int _id;
static BOOL isCloud;

@implementation LoginInfo

+(void)setIslogin:(BOOL)newlogin
{
    islogin = newlogin;
}
+(BOOL)islogin
{
    return islogin;
}

+(BOOL)isCloud
{
    return isCloud;
}

+(void)setIsCloud:(BOOL)newC
{
    isCloud = newC;
}

+(void)setName:(NSString *)newname
{
    name = newname;
}
+(NSString *)name
{
    return name;
}

+(void)setSex:(NSString *)newsex
{
    sex = [newsex isEqualToString:@"1"]?@"男":@"女";
}
+(NSString *)sex
{
    return sex;
}

+(void)setId:(int)newId
{
    _id = newId;
}
+(int)_id
{
    return _id;
}



@end

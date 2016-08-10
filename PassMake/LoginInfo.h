//
//  LoginInfo.h
//  Re
//
//  Created by hiroshika on 13-8-18.
//  Copyright (c) 2013年 hiroshika. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginInfo : NSObject

+(void)setIslogin:(BOOL)newlogin;
+(BOOL)islogin;

+(void)setName:(NSString *)newname;
+(NSString *)name;

+(void)setSex:(NSString *)newsex;
+(NSString *)sex;

+(void)setId:(int)newId;
+(int)_id;

+(BOOL)isCloud;
+(void)setIsCloud:(BOOL)newC;


@end

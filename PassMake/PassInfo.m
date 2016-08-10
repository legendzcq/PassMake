//
//  PassInfo.m
//  PassWordMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "PassInfo.h"

@implementation PassInfo

-(NSString *)description
{
    return [NSString stringWithFormat:@"%d,%@,%@",self._id,self.pass,self.title];
}

@end

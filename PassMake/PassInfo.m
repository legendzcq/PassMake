//
//  PassInfo.m
//  PassWordMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "PassInfo.h"
#import "LKDBTool.h"
@implementation PassInfo
//必须重写此方法
+ (NSDictionary *)describeColumnDict{
    LKDBColumnDes *account = [LKDBColumnDes new];
    //设置主键
//    account.primaryKey = YES;
    account.columnName = @"account";
//    account.notNull = YES;
//    account.autoincrement = YES;
    LKDBColumnDes *title = [LKDBColumnDes new];
    //设置主键
        title.primaryKey = YES;
    return @{@"_id":account,@"title":title};
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%d,%@,%@",self._id,self.pass,self.title];
}

@end

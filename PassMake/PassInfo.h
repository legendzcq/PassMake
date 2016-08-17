//
//  PassInfo.h
//  PassWordMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBModel.h"
@interface PassInfo : LKDBModel

@property (nonatomic,assign)int _id;
@property (nonatomic,copy) NSString *pass;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSData * imageData;
@end

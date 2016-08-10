//
//  PassDao.h
//  PassMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassInfo.h"

@interface PassDao : NSObject

+(id)shared;
-(void)create;
-(BOOL)addPass:(PassInfo *)pa;
-(NSMutableArray *)selectAllP;
-(BOOL)doDelete:(int)_id;

@end

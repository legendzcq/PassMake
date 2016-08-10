//
//  MyPass.h
//  PassWordMake
//
//  Created by 普科 on 13-8-18.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h> 

@interface MyPass : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate>

{
    NSString *currectTagName;
    NSString *xmlString;
}

@property (retain,nonatomic) NSString *xmlString;

-(NSString *)passMakeLenth:(int) length andHaveUp:(BOOL) haUp andHaveLow:(BOOL) haLow andHaveTeShu:(BOOL) haTeShu andHaveNumBer:(BOOL)haNum;
-(void)selectUser:(NSString *)username andPass:(NSString *)password;
-(void)selectPass:(int)userId;
-(void)insertUser:(NSString *)username andPass:(NSString *)passWord andSex:(NSString *)sex;
-(void)insertPass:(NSString *)pass andTitle:(NSString *)title andUserId:(int)userId;
-(void)deletePass:(int)passId;
- (NSString *)md5:(NSString *)str;
+(id)shared;
@end

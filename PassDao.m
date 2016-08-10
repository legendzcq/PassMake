//
//  PassDao.m
//  PassMake
//
//  Created by 普科 on 13-8-19.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "PassDao.h"
#import "sqlite3.h"
#import "PassInfo.h"

static PassDao *dao;

@implementation PassDao

-(NSString *)getFilePath{
    
    //设置文件保存的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取documents路径
    NSString *documentPath = [paths lastObject];
    //定义全路径
    NSString *savePath = [documentPath stringByAppendingPathComponent:@"pass.db"];
    
    return savePath;
}

+(id)shared
{
    if (nil == dao) {
        dao = [[PassDao alloc] init];
    }
    return dao;
}



/*
 create table if not exists pass(
    id int primary key autoincrement,
    title varchar(20),
    password varchar(16) not null)
 
 */

-(NSMutableArray *)selectAllP
{
    sqlite3 *db;
    NSString *dbFilePath = [self getFilePath];
    NSMutableArray *passs = [NSMutableArray array];
    if (sqlite3_open([dbFilePath UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        return NO;
        
    }else{
        NSString *allSql=@"select id,title,password from pass";
        sqlite3_stmt *statment;
        if (sqlite3_prepare_v2(db,[allSql UTF8String], -1, &statment, NULL)==SQLITE_OK) {
            while (sqlite3_step(statment)==SQLITE_ROW) {
                int mId = sqlite3_column_int(statment, 0);
                char *title=(char *)sqlite3_column_text(statment, 1);
                char *password=(char *)sqlite3_column_text(statment, 2);
                
                NSLog(@"%d--%s,--%s",mId,title,password);
                
                PassInfo *info = [[PassInfo alloc]init];
                info._id = mId;
                if(title)
                    info.title = [NSString stringWithUTF8String:title];
                if(password)
                    info.pass = [NSString stringWithUTF8String:password];
                [passs addObject:info];
                [info release];
            }
            
            sqlite3_finalize(statment);
            sqlite3_close(db);
            NSLog(@"---------");
        }
    }
    return [passs retain];
}

-(BOOL)doDelete:(int)_id
{
    sqlite3 *db;
    NSString *dbFilePath = [self getFilePath];
    if (sqlite3_open([dbFilePath UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        return NO;
        
    }else{
        
        //定义sql
        NSString *insertSql = @"delete from pass where id=?";
        //定义预处理命令
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            //绑定参数
            sqlite3_bind_int(statement, 1, _id);
            
            //执行，并判断是否成功
            if (sqlite3_step(statement)!=SQLITE_DONE){
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return NO;
                
            }
            
            return YES;
            
        }else{
            
            //预编译失败，执行代码
            
            sqlite3_finalize(statement);
            sqlite3_close(db);
            return NO;
            
        }
        
    }
    return YES;

}

-(BOOL)addPass:(PassInfo *)pa
{
    sqlite3 *db;
    //获取路径
    NSString *dbFilePath = [self getFilePath];
    if (sqlite3_open([dbFilePath UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        return NO;
        
    }else{
        
        //定义sql
        NSString *insertSql = @"insert into pass values(null,?,?);";
        //定义预处理命令
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            
            //绑定参数
            NSLog(@"%@",pa);
            sqlite3_bind_text(statement, 1, [pa.title UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [pa.pass UTF8String], -1, NULL);
            
            //执行，并判断是否成功
            if (sqlite3_step(statement)!=SQLITE_DONE){
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return NO;
                
            }
            
            return YES;
            
        }else{
            
            //预编译失败，执行代码
            
            sqlite3_finalize(statement);
            sqlite3_close(db);
            return NO;
            
        }
        
        
    }
}

-(void)create
{
    sqlite3 *db;
    NSString *fileName = [self getFilePath];
    NSLog(@"%@",fileName);
    if (sqlite3_open([fileName UTF8String], &db)) {
        sqlite3_close(db);
        NSAssert(NO,@"建立数据库失败");
    }else
    {
        char *err;
        //创建数据库
        NSString *createSql = @"create table if not exists pass(id integer primary key autoincrement,title varchar(20),password varchar(16) not null)";
        NSLog(@"%@",createSql);
        //执行sql
        if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"err = %s",err);
            //假言判断
            NSAssert(NO, @"数据表创建失败");
        }
        
        //关闭
        sqlite3_close(db);
    }
}

@end

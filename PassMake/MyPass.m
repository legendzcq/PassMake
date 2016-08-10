//
//  MyPass.m
//  PassWordMake
//
//  Created by 普科 on 13-8-18.
//  Copyright (c) 2013年 普科. All rights reserved.
//

#import "MyPass.h"
#import "UserInfo.h"
#import "PassInfo.h"
#import "AppDelegate.h"
#import "LoginInfo.h"
#import "PassViewController.h"

static MyPass *pa;

@implementation MyPass

+(id)shared
{
    if (!pa) {
        pa = [[MyPass alloc] init];
    }
    return pa;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    NSString *resu = [NSString stringWithFormat:@""];
    for (int i = 0; i<16; i++) {
        resu = [resu stringByAppendingFormat:@"%02x",result[i]];
    }
    return resu;
}

@synthesize xmlString; 

typedef enum {
    selectPass,
    selectUser,
    insertUser,
    insertPass,
    deletePass
}H;
H h;

NSString *ip = @"http://169.254.100.226:8080/JiShuQi/";
NSMutableArray *passs;


-(void)deletePass:(int)passId
{
    h = deletePass;
    NSString *ipP = [ip stringByAppendingFormat:@"delete?id=%d",passId];
    NSString *encoded = [ipP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encoded];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]  initWithRequest:re delegate:self];
    NSLog(@"hehe");
}

-(NSString *)passMakeLenth:(int) length andHaveUp:(BOOL) haUp andHaveLow:(BOOL) haLow andHaveTeShu:(BOOL) haTeShu andHaveNumBer:(BOOL)haNum
{
    
    if (length <= 0 || (!haLow && !haNum && !haTeShu && !haUp)) {
        return @"";
    }
    
    char te[] = {'!','@','#','$','%','^','&','*','(',')','_','+','-','='};
    
    NSMutableString *str = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i<length; i++) {
        char shuzi[] = {(arc4random() % 10) + '0','\0'};
        char up[] = {(arc4random() % 27) + 'A','\0'};
        char low[] = {(arc4random() % 27) + 'a','\0'};
        char teshu[] = {te[((arc4random() % (sizeof(te)/1)))],'\0'};
        
        int j = 0;
        NSMutableArray *myA = [NSMutableArray array];
        if (haUp) {
            [myA addObject:[NSString stringWithUTF8String:up]];
            j++;
        }
        if (haLow) {
            [myA addObject:[NSString stringWithUTF8String:low]];
            j++;
        }
        if (haNum) {
            [myA addObject:[NSString stringWithUTF8String:shuzi]];
            j++;
        }
        if (haTeShu) {
            [myA addObject:[NSString stringWithUTF8String:teshu]];
            j++;
        }
        [str appendString:[myA objectAtIndex:(arc4random() % j)]];
    }
    
    return str;
}//36line

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)insertPass:(NSString *)pass andTitle:(NSString *)title andUserId:(int)userId
{
    h = insertPass;
    NSString *ipP = [ip stringByAppendingFormat:@"insertPass?userid=%d&pass=%@&title=%@",userId,pass,title];
    NSString *encoded = [ipP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"encoded=%@",encoded);
    NSURL *url = [NSURL URLWithString:encoded];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]  initWithRequest:re delegate:self];
    NSLog(@"hehe");
}

-(void)insertUser:(NSString *)username andPass:(NSString *)passWord andSex:(NSString *)sex
{
    h = insertUser;
    passWord = [self md5:passWord];
    NSLog(@"%@,%d",passWord,passWord.length);
    sex = [sex isEqualToString:@"男"] ? @"1":@"2";
    NSString *ipP = [ip stringByAppendingFormat:@"insert?username=%s&password=%s&sex=%s",[username UTF8String],[passWord UTF8String],[sex UTF8String]];
    NSString *encoded = [ipP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encoded];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]  initWithRequest:re delegate:self];
    NSLog(@"hehe");
}

-(void)selectUser:(NSString *)username andPass:(NSString *)password
{
    h = selectUser;
    password = [self md5:password];
    info = [[UserInfo alloc] init];
    NSString *ipP = [ip stringByAppendingFormat:@"selectUser?username=%@&password=%@",username,password ];
    NSString *encoded = [ipP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encoded];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]  initWithRequest:re delegate:self];
    NSLog(@"hehe");
}

-(void)selectPass:(int)userId
{
    h = selectPass;
    passs = [[NSMutableArray alloc] init];
    NSString *ipP = [ip stringByAppendingFormat:@"selectPass?userid=%d",userId ];
    NSString *encoded = [ipP stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encoded];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc]  initWithRequest:re delegate:self];
    NSLog(@"hehe");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"连接出错！！%@",[error description]);
    
}


//当连接失败的时候调用的方法

//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    //获取数据
    NSStringEncoding gbkToUtf8 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //获取返回的内容
    NSString *str = [[NSString alloc] initWithData:data encoding:gbkToUtf8];
    if (h == insertUser) {
        if ([str isEqualToString:@"1"])
        {
            AppDelegate *now = [[UIApplication sharedApplication] delegate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"注册成功" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            now.window.rootViewController = (UIViewController *)now.dengLuViewController;
        }
        else if([str isEqualToString:@"0"])
        {
            AppDelegate *now = [[UIApplication sharedApplication] delegate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"注册失败，请重试" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([str isEqualToString:@"-1"])
        {
            AppDelegate *now = [[UIApplication sharedApplication] delegate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"用户名已存在" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        return;
    }
    
    if (h == deletePass) {
        NSLog(@"delete = %@",str);
        AppDelegate *now = [[UIApplication sharedApplication] delegate];
        if ([str isEqualToString:@"1"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"删除密码成功" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else if ([str isEqualToString:@"-1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"删除密码失败" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self selectPass:[LoginInfo _id]];
        return;
    }
    
    if (h == insertPass) {
        NSLog(@"insertPass");
        NSLog(@"str=%@",str);
        if ([str isEqualToString:@"1"]) {
            AppDelegate *now = [[UIApplication sharedApplication] delegate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"插入密码成功" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            now.window.rootViewController = (UIViewController *)now.makePassViewController;
        }else if ([str isEqualToString:@"-1"]){
            AppDelegate *now = [[UIApplication sharedApplication] delegate];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"插入密码失败" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        return;
    }
    if (h == selectUser && [str isEqualToString:@"1"]) {
        AppDelegate *now = [[UIApplication sharedApplication] delegate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"密码错误" delegate:[[now window ]rootViewController] cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    self.xmlString = [str stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" ];
    
    //NSLog(@"data :%@",self.xmlString);
}

//当数据全部加载完成以后执行的方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //开始进行解析
//    NSLog(@"xmlString :-----%@",self.xmlString);
    //构建XML解析对象
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:[self.xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    //设置委托
    xmlParser.delegate = self;
    //开始解析
    [xmlParser parse];
    
}

//文档开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    //初始化字典
//    resultDict  = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    
}

//解析出错的时候
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    
}

//标签开始的时候
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"TagName :%@",elementName);
    currectTagName = elementName;
    if (h == selectPass && [elementName isEqualToString:@"pass"]) {
        pass = [[PassInfo alloc] init];
    }
    
}

//标签结束的时候
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"userinfo"] && info._id != 0) {
        [LoginInfo setIslogin:YES];
        [LoginInfo setName:info.username];
        [LoginInfo setSex:info.sex];
        [LoginInfo setId:info._id];
        AppDelegate *now = [[UIApplication sharedApplication] delegate];
        now.window.rootViewController = (UIViewController *)now.makePassViewController;
    }
//    NSLog(@"%@",elementName);
    NSLog(@"fuck");
    if (h == selectPass && [elementName isEqualToString:@"all"]) {
        NSLog(@"arr=%@",passs);
        NSLog(@"finish1");
        AppDelegate *now = [UIApplication sharedApplication].delegate;
        NSLog(@"finish2");
        now.window.rootViewController = (UIViewController *)[[PassViewController alloc] initWithNibName:@"PassViewController" bundle:nil andArr:passs];
        NSLog(@"finish");
    }
    if (h == selectPass && [elementName isEqualToString:@"pass"]) {
        [passs addObject:pass];
    }
    
}
PassInfo *pass ;
int i = 0;
//遇到字符，就执行该方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
//    NSLog(@"******* :%@",string);
//    NSLog(@"i = %d",i);
    //把回车换成“”
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if (h == selectPass)
    {
        if ([currectTagName isEqualToString:@"id"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                //以标签名作为key,以当前string作为值来使用
                //            [resultDict setValue:string forKey:currectTagName];
//                NSLog(@"JB");
                pass._id = string.intValue;
            }
            
        }else if ([currectTagName isEqualToString:@"passN"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                //以标签名作为key,以当前string作为值来使用
                //            [resultDict setValue:string forKey:currectTagName];
//                NSLog(@"passN=%@",string);
                pass.pass = string;
            }
            
        }else if ([currectTagName isEqualToString:@"titleN"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                pass.title = string;
            }
            
        }
//        NSLog(@"%@",pass);
    
    }
    else if (h == selectUser)
    {
        
        if ([currectTagName isEqualToString:@"id"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                //以标签名作为key,以当前string作为值来使用
                //            [resultDict setValue:string forKey:currectTagName];
//                NSLog(@"JB");
                info._id = string.intValue;
            }
            
        }else if ([currectTagName isEqualToString:@"username"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                //以标签名作为key,以当前string作为值来使用
                //            [resultDict setValue:string forKey:currectTagName];
                info.username = string;
            }
            
        }else if ([currectTagName isEqualToString:@"sex"]) {
            //判断字符不为空的时候保存
            if (![string isEqualToString:@""]) {
                //以标签名作为key,以当前string作为值来使用
                //            [resultDict setValue:string forKey:currectTagName];
                info.sex = string;
            }
        }
        
    }
}
UserInfo *info;

@end

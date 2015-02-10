//
//  EZAppHelper.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZAppHelper.h"
#import "MF_Base64Additions.h"
static EZAppHelper *helper;
@implementation EZAppHelper
#pragma mark 通用持久化操作
+(EZAppHelper *)shareAppHelper
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        
        helper=[[EZAppHelper alloc]init];
        
        
        
    });
    
    
    return helper;
}


-(instancetype)init
{
    
    
    if (self=[super init]) {
        
        
        
        
        _history_record=[NSMutableArray arrayWithArray:[self loadItemsFromFile:@"history"]];
        
        
        
        
        
    }
    
    
    
    return self;
    
    
}

- (void)saveItemsToFile:(NSArray *)items cacheId:(NSString *)cacheId {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"cache_%@", cacheId];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    [items writeToFile:path atomically:YES];
    
    
}

- (NSArray *)loadItemsFromFile:(NSString *)cacheId {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"cache_%@", cacheId];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    
    NSArray *items = [[NSArray alloc] initWithContentsOfFile:path];//[NSMutableArray arrayWithContentsOfFile:path];
    //NSLog(@"%@",items);
    if (items == nil)
        items = [[NSMutableArray alloc] initWithCapacity:20];
    return items;
    
}

-(void)addHistoryWithDic:(NSDictionary *)item
{

    
    [_history_record removeObject:item];
    
    

    [_history_record insertObject:item atIndex:0];
    
    
    
    
    
    [self saveItemsToFile:_history_record cacheId:@"history"];



}


-(NSDictionary *)happy_base64_decode:(NSString *)source
{
    
    NSString *str=@"";
    
    
    for (int i=0; i<source.length; i++) {
        
        int n=[[source substringWithRange:NSMakeRange(i, 1)] characterAtIndex:0];//ASCII码
        
        
        int n2;
        
        //A-Z a-z 0-9只对这些做处理
        
        if ((n>=48&&n<=57)||(n>=65&&n<=90)||(n>=97&&n<=122)) {
            
            
            n2=n-i%10;//减去除以0到9的余数
            
            
            //超出范围的转化到范围里去,比如原先数载57以下，加了余数后，会在65到90之间，跳过中间的，57之后就是65。反之解码相减也是这样
            
            if (n2<48) {
                
                
                n2=122-(48-n2)+1;
                
            }else if (n>=65&&n2<65)
            {
            
                n2=57-(65-n2)+1;
            
            
            }else if (n>=97&&n2<97)
            {
            
            
                n2=90-(97-n2)+1;
            
            }
            
            
            
        }else
        {
        
        
            n2=n;
        
        
        }
        
        
        
        str=[str stringByAppendingString:[NSString stringWithFormat:@"%C",(unichar)n2]];
        
        
        
    }
    
    
    
    
    NSData *data=[NSData dataWithBase64String:str];
    
    
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    
    
    return dic;
    
}






@end

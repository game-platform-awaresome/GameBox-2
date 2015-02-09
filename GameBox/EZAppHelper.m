//
//  EZAppHelper.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZAppHelper.h"
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

@end

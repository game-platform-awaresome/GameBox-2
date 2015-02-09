//
//  EZAppHelper.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZAppHelper : NSObject
@property(nonatomic,strong)NSMutableArray *history_record;
+(EZAppHelper *)shareAppHelper;
@end

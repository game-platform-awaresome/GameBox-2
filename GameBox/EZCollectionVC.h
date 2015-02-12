//
//  EZCollectionVC.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{

  EZCollectionTypeRecommend=0,
  EZCollectionTypeNew=1,
  EZCollectionTypeHot=2,
    
  EZCollectionTypeSearch=3,
    
  EZCollectionTypeLoved=4

} EZCollectionType;
@interface EZCollectionVC : UICollectionViewController
{

    int mPage;
    
    
    
    NSMutableArray *mItems;

}
@property(assign,nonatomic)EZCollectionType mType;
@property(strong,nonatomic)NSString *mKeyword;
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout AndType:(EZCollectionType)type;
-(void)refreshData;
@end

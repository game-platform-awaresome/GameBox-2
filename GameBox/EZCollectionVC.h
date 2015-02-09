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
  EZCollectionTypeHot=2

} EZCollectionType;
@interface EZCollectionVC : UICollectionViewController
{

    int mPage;

}
@property(assign,nonatomic)EZCollectionType mType;
@end

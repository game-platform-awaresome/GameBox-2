//
//  EZSegmentView.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol EZSegmentDelegate <NSObject>

-(void)segmentClick:(UIButton *)sender;

@end

@interface EZSegmentView : UIImageView
{
    
    NSArray *imageItems;
    
    NSArray *selectedImageItems;
    
    
}
@property(weak,nonatomic)UIViewController<EZSegmentDelegate> * delegate;

-(instancetype)initWithImageItems:(NSArray *)items selectedImageItems:(NSArray *)selectedItems andBackground:(UIImage *)image;
@end



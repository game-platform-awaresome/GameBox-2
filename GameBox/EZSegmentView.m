//
//  EZSegmentView.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZSegmentView.h"

@implementation EZSegmentView
-(instancetype)initWithImageItems:(NSArray *)items selectedImageItems:(NSArray *)selectedItems andBackground:(UIImage *)image
{
    
    if (self=[super init]) {
        
        
        
        imageItems=items;
        
        selectedImageItems=selectedItems;
        
        self.image=image;
        
        self.userInteractionEnabled=YES;
        
        //       [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    
    return self;
    
}


-(void)layoutSubviews
{
    
    self.frame=CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    
    for (UIButton *button in self.subviews) {
        [button removeFromSuperview];
    }
    
    
    
    int width=self.superview.frame.size.width/imageItems.count;
    
    int height=self.superview.frame.size.height;
    
    
    for (int i=0; i<imageItems.count; i++) {
        
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        button.frame=CGRectMake(i*width, 0, width,height);
        
        button.tag=i+1000;
        
        
        UIImage *normal=[UIImage imageNamed:imageItems[i]];
        
        UIImage *selectedImage=[UIImage imageNamed:selectedImageItems[i]];
        
        
        [button setImage:normal forState:UIControlStateNormal];
        
        
        if (i==0) {
            
            
            [button setImage:selectedImage forState:UIControlStateNormal];
            
        }
        
        
        [button setImage:selectedImage forState:UIControlStateHighlighted];
        
        
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
-(void)tabButtonPressed:(UIButton *)sender
{
    
    
    
    
    
    
    [self clearImage];
    
    UIImage *pressedImage = [UIImage imageNamed:[selectedImageItems objectAtIndex:sender.tag-1000]];
    
    [sender setImage:pressedImage forState:UIControlStateNormal];
    
    
    if (_delegate&&[_delegate respondsToSelector:@selector(segmentClick:)]) {
        [_delegate performSelector:@selector(segmentClick:) withObject:sender];
    }
    
    
    
    
    
    
    
}

-(void)clearImage
{
    
    
    for (UIButton *button in self.subviews) {
        
        UIImage *normalImage=[UIImage imageNamed:[imageItems objectAtIndex:button.tag-1000]];
        [button setImage:normalImage forState:UIControlStateNormal];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

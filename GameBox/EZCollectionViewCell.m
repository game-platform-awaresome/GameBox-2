//
//  EZCollectionViewCell.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation EZCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"cell_bg"]resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)]]];
    
    
}
-(void)setInfo:(NSDictionary *)item
{

    self.titleLbl.text=[item objectForKey:@"title"];
    
    
    self.infoLbl.text=[item objectForKey:@"short_desc"];
    
    
    
    NSString *image=[NSString stringWithFormat:@"%@",[item objectForKey:@"icon"]];


    [self.iconView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"cell_icon"]];

}
@end

//
//  IndexViewController.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZSegmentView.h"
#import "EZCollectionVC.h"
@interface IndexViewController : UIViewController<EZSegmentDelegate>
{


    EZCollectionVC *recommendCollection;
    
    
    EZCollectionVC *newCollection;
    
    
    
    EZCollectionVC *hotCollection;

   
    NSDictionary *mainGame;


}
@property (weak, nonatomic) IBOutlet UIView *topSwitchBg;
@property(strong,nonatomic)EZSegmentView *mSegmentView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)goToSearch:(UIButton *)sender;
- (IBAction)playNow:(UIButton *)sender;
@end

//
//  IndexViewController.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initSegmentView];
   
    
    [self initCollectionViews];
    
    
  
    
    // Do any additional setup after loading the view.
}
-(void)initSegmentView
{


 [self.topSwitchBg layoutIfNeeded];

    self.mSegmentView=[[EZSegmentView alloc]initWithImageItems:@[@"tuijian",@"zuixin",@"zuire"] selectedImageItems:@[@"tuijian_high",@"zuixin_high",@"zuire_high"] andBackground:nil];

    [self.topSwitchBg addSubview:self.mSegmentView];
    _mSegmentView.delegate=self;


}

-(void)segmentClick:(UIButton *)sender
{


    NSLog(@"%@:%ld",NSStringFromSelector(_cmd),(long)sender.tag);


    //NSLog(@"触摸了%d",tag);
    
    recommendCollection.view.hidden=YES;
    newCollection.view.hidden=YES;
    hotCollection.view.hidden=YES;
    
    
    switch (sender.tag) {
        case 1000:
            recommendCollection.view.hidden=NO;
            break;
        case 1001:
            if (newCollection==nil) {
                
                
                UICollectionViewFlowLayout * Layout=[[UICollectionViewFlowLayout alloc]init];
                
                Layout.itemSize=CGSizeMake((SCREEN_WIDTH-16)/2, 102);
                Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
                
                Layout.minimumInteritemSpacing=2;
                Layout.minimumLineSpacing=2;
                
                
                Layout.sectionInset=UIEdgeInsetsMake(7, 7, 7, 7);


                newCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:Layout AndType:EZCollectionTypeNew];
                
                newCollection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
            
                [self addChildViewController:newCollection];
                
                [_bottomView addSubview:newCollection.view];
                
                
                
                newCollection.view.hidden=YES;
            }
            newCollection.view.hidden=NO;
            break;
        case 1002:
            if (hotCollection==nil) {
                
                
                
                UICollectionViewFlowLayout * Layout=[[UICollectionViewFlowLayout alloc]init];
                
                
                Layout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/2, 100);
                Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
                
                Layout.minimumInteritemSpacing=4;
                
                Layout.sectionInset=UIEdgeInsetsMake(7, 7, 2, 7);

                hotCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:Layout AndType:EZCollectionTypeHot];
                hotCollection.mType=EZCollectionTypeHot;
                hotCollection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
                
                [self addChildViewController:hotCollection];
                
                [_bottomView addSubview:hotCollection.view];
                
                
                
                
                hotCollection.view.hidden=YES;
                
                
            }
            hotCollection.view.hidden=NO;
            break;
        default:
            break;
    }
    
    






}

-(void)initCollectionViews
{

    
    
    [self.bottomView layoutIfNeeded];

    
    
    
    
   UICollectionViewFlowLayout * Layout=[[UICollectionViewFlowLayout alloc]init];
    
    
    Layout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/2, 100);
    Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    Layout.minimumInteritemSpacing=4;
    
    Layout.sectionInset=UIEdgeInsetsMake(7, 7, 2, 7);
    
    
    
    
    
    
    recommendCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:Layout AndType:EZCollectionTypeRecommend];
    recommendCollection.mType=EZCollectionTypeRecommend;
    recommendCollection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    
    [self addChildViewController:recommendCollection];
    
    [_bottomView addSubview:recommendCollection.view];
    
    
    
    
//    newCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:mLayout];
//    
//    newCollection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
//    newCollection.mType=EZCollectionTypeNew;
//    [self addChildViewController:newCollection];
//    
//    [_bottomView addSubview:newCollection.view];
//
//    
//    
//    
//    hotCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:mLayout];
//    hotCollection.mType=EZCollectionTypeHot;
//    hotCollection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
//    
//    [self addChildViewController:hotCollection];
//    
//    [_bottomView addSubview:hotCollection.view];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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

    self.mSegmentView=[[EZSegmentView alloc]initWithImageItems:@[@"btn_contact",@"huangye",@"wode"] selectedImageItems:@[@"btn_contact_hig",@"huangye_hig",@"wode_hig"] andBackground:nil];

    [self.topSwitchBg addSubview:self.mSegmentView];
    _mSegmentView.delegate=self;


}

-(void)segmentClick:(UIButton *)sender
{


    NSLog(@"%@:%ld",NSStringFromSelector(_cmd),(long)sender.tag);








}

-(void)initCollectionViews
{

    
    
    [self.bottomView layoutIfNeeded];

    
    
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    
    layout.itemSize=CGSizeMake((SCREEN_WIDTH-40)/2, 90);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    layout.minimumInteritemSpacing=20;
    
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    EZCollectionVC *collection=[[EZCollectionVC alloc]initWithCollectionViewLayout:layout];
    
    collection.view.frame=CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    
    [self addChildViewController:collection];
    
    [_bottomView addSubview:collection.view];



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

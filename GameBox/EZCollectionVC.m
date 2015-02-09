//
//  EZCollectionVC.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZCollectionVC.h"
#import "EZCollectionViewCell.h"
#import "MJRefresh.h"
@interface EZCollectionVC ()

@end

@implementation EZCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"EZCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
        
    mPage=1;
    
    
    [self loadData];
    
    [self setRefresh];
    
    // Do any additional setup after loading the view.
}
-(void)loadData
{


    mPage=1;





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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EZCollectionViewCell *cell =(EZCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.playButton addTarget:self action:@selector(playGame:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


    
   
    
    
    

}



/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(void)playGame:(UIButton *)sender event:(UIEvent*)event
{


    NSSet *touches=[event allTouches];
    
    UITouch *touch=[touches anyObject];
    
    
    CGPoint point=[touch locationInView:self.collectionView];
    
    
    NSIndexPath *indexPath=[self.collectionView indexPathForItemAtPoint:point];
    
    
    
    
    }










-(void)setRefresh
{
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
- (void)footerRereshing
{
    
   // [SVProgressHUD showWithStatus:@"正在加载..."];
    
    mPage++;
    
    
    
    
}

@end

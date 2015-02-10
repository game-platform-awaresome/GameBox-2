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
#import "EZPlayerViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "EZAppHelper.h"
@interface EZCollectionVC ()

@end

@implementation EZCollectionVC

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout AndType:(EZCollectionType)type
{

    if (self=[super initWithCollectionViewLayout:layout]) {
        
        
        _mType=type;
        
    }


    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"EZCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
        
    mPage=1;
    
    
    [self refreshData];
    
    [self setRefresh];
    
    // Do any additional setup after loading the view.
}
-(void)refreshData
{


    mPage=1;


    [self loadData];


}
-(void)loadData
{




    NSString *temp=@"http://93app.com/game/h5/game_list.php?ucode=%@&version=%@&order_type=%@&page=%d";
    
    
    
    NSString *strUrl;
    
    
    
    switch (_mType) {
        case EZCollectionTypeRecommend:
            
            
            
            strUrl=[NSString stringWithFormat:temp,UID,VERSION,@"recommoned",mPage];
            
            break;
        case EZCollectionTypeNew:
            strUrl=[NSString stringWithFormat:temp,UID,VERSION,@"new",mPage];
            break;
        case EZCollectionTypeHot:
            strUrl=[NSString stringWithFormat:temp,UID,VERSION,@"hot",mPage];
            break;
            
        default:
            break;
    }
    
    
    
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    
    
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
        
       NSDictionary *dic=[[EZAppHelper shareAppHelper]happy_base64_decode:[[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding]];
        
       
        
        if ([[dic objectForKey:@"status"]intValue]==1) {
            
          
            
            if (mItems==nil) {
                mItems =[NSMutableArray arrayWithCapacity:10];
            }
            
            
            NSArray *tempArray=[dic objectForKey:@"game_list"];
            
            
            if (mPage==1) {
                
                
                [mItems removeAllObjects];
                
                
            }
            
            
            [mItems addObjectsFromArray:tempArray];
            
            
            [self.collectionView reloadData];
            
        }else
        {
        
        
        
        
           
        
        
        
        
        
        
        
        }
        
        
        
        
         [self.collectionView footerEndRefreshing];
        
        NSLog(@"%@",dic);
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [self.collectionView footerEndRefreshing];
        
    }];
    
    

    
    
    
    
    
    






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
    return mItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EZCollectionViewCell *cell =(EZCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.playButton addTarget:self action:@selector(playGame:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSDictionary *item=[mItems objectAtIndex:indexPath.row];
    
    
    
    [cell setInfo:item];
    
    
    
    
    
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


    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   
    EZPlayerViewController *player=[storyboard instantiateViewControllerWithIdentifier:@"EZPlayerViewController"];
    
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:player];
    
     NSDictionary *item=[mItems objectAtIndex:indexPath.row];
    
    
    player.myItem=item;
    
    
    [self presentViewController:nav animated:YES completion:nil];
    
    

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
    
    
    
   
    
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    EZPlayerViewController *player=[storyboard instantiateViewControllerWithIdentifier:@"EZPlayerViewController"];
    
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:player];

    
  
    
    NSDictionary *item=[mItems objectAtIndex:indexPath.row];
    
    
    player.myItem=item;
    
    
    [self presentViewController:nav animated:YES completion:nil];

    
    
    
    
    
    }










-(void)setRefresh
{
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
- (void)footerRereshing
{
    
   // [SVProgressHUD showWithStatus:@"正在加载..."];
    
    mPage++;
    
    
    [self loadData];
    
}

@end

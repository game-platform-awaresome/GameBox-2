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
#import "EZSearchViewController.h"
#import "SVProgressHUD.h"
#import "CollectionReusableView.h"
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
-(void)dealloc
{

    if (_mType==EZCollectionTypeRecommend) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"history" object:nil];
        
        
        
         }
    

   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"remove" object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"EZCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
        
    mPage=1;
    
    
    if (_mType!=EZCollectionTypeSearch&&_mType!=EZCollectionTypeLoved) {
        
         [self refreshData];
        
    }
    
    if (_mType!=EZCollectionTypeLoved) {
          [self setRefresh];
    }
  
    
    if (_mType==EZCollectionTypeRecommend) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCollectionData) name:@"history" object:nil];
       

        
        
    }
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearHistory) name:@"remove" object:nil];
    if (_mType==EZCollectionTypeLoved) {
        
        
        
        
        mItems=[EZAppHelper shareAppHelper].history_record;
        [self.collectionView reloadData];
        
        [self initNav];
        
        
        
        
        
        
        
        
    }
    UINib *headerNib = [UINib nibWithNibName:NSStringFromClass([CollectionReusableView class])  bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:headerNib  forSupplementaryViewOfKind :UICollectionElementKindSectionHeader  withReuseIdentifier: @"title" ];  //注册加载头

    
    // Do any additional setup after loading the view.
}

-(void)reloadCollectionData
{

    
    
    
    [self.collectionView reloadData];


}

//清除已关注
-(void)clearHistory
{

    
    
    
   
    
  

    
    
    [self.collectionView reloadData];
    
    
    
    

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
    
    if (_mType!=EZCollectionTypeSearch) {
        switch (_mType) {
            case EZCollectionTypeRecommend:
                
                
                
                strUrl=[NSString stringWithFormat:temp,UID,VERSION,@"recommend",mPage];
                
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

    }else
    {
    
    
        strUrl=[NSString stringWithFormat:@"http://93app.com/game/h5/search.php?ucode=%@&version=%@&keyword=%@&page=%d",UID,VERSION,_mKeyword,mPage];
    
        
        strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
    
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
            
            
            NSMutableArray *tempArray=[[dic objectForKey:@"game_list"] mutableCopy];
            
            
            
            
            
            
            
            
            
            
            
            
            if (mPage==1) {
                
                
                [mItems removeAllObjects];
                
                
                
                
                
                
                
            }
            
            
            
            
            
            [mItems addObjectsFromArray:tempArray];

            
            

            
           
            
            
            [self.collectionView reloadData];
            
        }else
        {
        
        
        
        
           
            if (mPage==1) {
                [mItems removeAllObjects];
                
                [self.collectionView reloadData];
            }
        
        
        
        
        
        
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
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (_mType==EZCollectionTypeRecommend) {
        
        
        if (section==0) {
            
            
            if ([EZAppHelper shareAppHelper].history_record.count<=0) {
                
                
                return CGSizeZero;;
                
                
            }else
            {
               return CGSizeMake(SCREEN_WIDTH, 20.0f);
                
            }

            
        }else
        {
        
         return CGSizeMake(SCREEN_WIDTH, 20.0f);
        
        }
        
        
       
        
    }
    
    
    return CGSizeZero;
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"title"forIndexPath:indexPath];
    
    
    if (indexPath.section==0) {
        
        view.titleLbl.text = @"我玩过的";

        
    }else if (indexPath.section==1)
    {
    
      view.titleLbl.text = @"最多人玩";
    
    
    }
    
    
    return view;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    
    
    if (_mType==EZCollectionTypeRecommend) {
        return 2;
    }
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    
    
    if (_mType==EZCollectionTypeRecommend) {
        
        
        if (section==0) {
            return [EZAppHelper shareAppHelper].history_record.count;
        }

        
    }

    
    
    return mItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EZCollectionViewCell *cell =(EZCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.playButton addTarget:self action:@selector(playGame:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (_mType==EZCollectionTypeRecommend) {
    
        if (indexPath.section==0) {
            
            
            NSDictionary *item=[[EZAppHelper shareAppHelper].history_record objectAtIndex:indexPath.row];
            
            
            
            [cell setInfo:item];
            
            
            
            
        }else if(indexPath.section==1)
        {
            
            
            NSDictionary *item=[mItems objectAtIndex:indexPath.row];
            
            
            
            [cell setInfo:item];
            
            
        }

    
    }else
    {
    
    
        NSDictionary *item=[mItems objectAtIndex:indexPath.row];
        
        
        
        [cell setInfo:item];
    
    
    
    }

    
    
    
    
    
    
    
    
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
    
    
    NSDictionary *item;
    
    
    
    
    if (_mType==EZCollectionTypeRecommend) {
    
    
        if (indexPath.section==0) {
            
            
            item=[[EZAppHelper shareAppHelper].history_record objectAtIndex:indexPath.row];
            
            
            
            
        }else if(indexPath.section==1)
        {
            
            
            item=[mItems objectAtIndex:indexPath.row];
            
            
            
            
        }
        

    
    }else
    {
    
    
        item=[mItems objectAtIndex:indexPath.row];

    
    
    }
    
    
    
    
    [self addHitsWithGameID:[item objectForKey:@"serial"]];
    
    
    player.myItem=item;
    
    
    [self presentViewController:nav animated:YES completion:^{
    
    [[EZAppHelper shareAppHelper]addHistoryWithDic:item];
        
        EZCollectionViewCell *cell=(EZCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [cell setInfo:item];
        
    
    }];
    
    
    
    
    
    

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

    
    
    NSDictionary *item;
    
    
    
    
    if (_mType==EZCollectionTypeRecommend) {
        
        
        if (indexPath.section==0) {
            
            
            item=[[EZAppHelper shareAppHelper].history_record objectAtIndex:indexPath.row];
            
            
            
            
        }else if(indexPath.section==1)
        {
            
            
            item=[mItems objectAtIndex:indexPath.row];
            
            
            
            
        }
        
        
        
    }else
    {
        
        
        item=[mItems objectAtIndex:indexPath.row];
        
        
        
    }

  
    
   
    
    
     [self addHitsWithGameID:[item objectForKey:@"serial"]];
    
    player.myItem=item;
    
    
    [self presentViewController:nav animated:YES completion:^{
    
      [[EZAppHelper shareAppHelper]addHistoryWithDic:item];
        EZCollectionViewCell *cell=(EZCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        [cell setInfo:item];

    
    }];

    
   
    
    
    
   
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



-(void)addHitsWithGameID:(NSString *)gameID
{






    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:[NSString stringWithFormat:@"http://93app.com/game/h5/proc/hits.php?ucode=%@&version=%@&serial=%@",UID,VERSION,gameID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
         NSDictionary *dic=[[EZAppHelper shareAppHelper]happy_base64_decode:[[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding]];
        
        
        NSLog(@"%@:%@",NSStringFromSelector(_cmd),dic);
        
        if ([dic objectForKey:@"status"]) {
            
            
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       
    
        
        
        
    
    }];






}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

   
    UIViewController *controller=self.parentViewController;
    
    if ([controller isKindOfClass:[EZSearchViewController class]]) {
        
        EZSearchViewController *temp=(EZSearchViewController *)controller;
        
        if ([temp.searchBar isFirstResponder]) {
             [temp.view endEditing:YES];
        }
        
        
        
        
        
    }
    
    
    
        
        
        
    




}
-(void)initNav
{



    self.navigationItem.title=@"关注游戏";
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(backButtonPresed) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backIyem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    
    self.navigationItem.leftBarButtonItem=backIyem;



}
-(void)backButtonPresed
{


    [self.navigationController popViewControllerAnimated:YES];



}
@end

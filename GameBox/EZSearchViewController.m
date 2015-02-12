//
//  EZSearchViewController.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/11.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZSearchViewController.h"
#import <Masonry/Masonry.h>
#import "SKTag.h"
#import "UIColor+Art.h"
#import "HexColor.h"
#import "AFHTTPRequestOperationManager.h"
#import "EZAppHelper.h"

@interface EZSearchViewController ()<UIGestureRecognizerDelegate>

@end

@implementation EZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    mKeywords=[NSMutableArray arrayWithCapacity:10];
    
    self.colorPool = @[@"#7ecef4", @"#84ccc9", @"#88abda",@"#7dc1dd",@"#b6b8de"];
    
    
    [self getKeywords];
    
    
    
  

    
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    
    
    
    [self initCollectionViews];
    
    
    // Do any additional setup after loading the view.
}

-(void)initCollectionViews
{
    
    
    
    [_collectionBg layoutIfNeeded];
    
    
    
    
    
    UICollectionViewFlowLayout * Layout=[[UICollectionViewFlowLayout alloc]init];
    
    
    Layout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/2, 100);
    Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    Layout.minimumInteritemSpacing=4;
    
    Layout.sectionInset=UIEdgeInsetsMake(7, 7, 2, 7);
    
    
    
    
    
    
    searchResult=[[EZCollectionVC alloc]initWithCollectionViewLayout:Layout AndType:EZCollectionTypeSearch];
    searchResult.mType=EZCollectionTypeSearch;
    searchResult.view.frame=CGRectMake(0, 0, _collectionBg.frame.size.width, _collectionBg.frame.size.height);
    
    [self addChildViewController:searchResult];
    
    [_collectionBg addSubview:searchResult.view];
    _collectionBg.hidden=YES;
    
   
    
        
    
    
    
}

-(void)getKeywords
{




    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:[NSString stringWithFormat:@"http://93app.com/game/h5/hot_keywords.php?ucode=%@&version=%@&page=1",UID,VERSION] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSDictionary *dic=[[EZAppHelper shareAppHelper]happy_base64_decode:[[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding]];
        
        
        NSLog(@"%@:%@",NSStringFromSelector(_cmd),dic);
        
        if ([[dic objectForKey:@"status"] intValue]==1) {
            
            
            
            NSArray *temp=[dic objectForKey:@"keywords_list"];
            
            
            [mKeywords addObjectsFromArray:temp];
            
             [self setupTagView];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        
        
        
        
    }];

    




}





- (void)setupTagView
{
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = UIColor.whiteColor;
        view.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        view.insets    = 15;
        view.lineSpace = 10;
       // __weak SKTagView *weakView = view;
        view.didClickTagAtIndex = ^(NSUInteger index){
            //Remove tag
           // [weakView removeTagAtIndex:index];
            
            
            
            NSString *text=[[mKeywords objectAtIndex:index]objectForKey:@"keyword"];
            
            _searchBar.text=text;
            [self searchWithKeyword:text];
            
            
            
            
            
        };
        view;
    });
    [self.keywordsView addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.keywordsView;
        //make.centerY.equalTo(superView.mas_centerY).with.offset(0);
        
        make.top.equalTo(superView.mas_top);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
    
    //Add Tags
    [mKeywords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         
         
         NSString *text=[obj objectForKey:@"keyword"];
         
         
         SKTag *tag = [SKTag tagWithText:text];
         tag.textColor = [UIColor whiteColor];
         tag.fontSize = 15;
         tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
         tag.bgColor = [UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count]];
         tag.cornerRadius = 5;
         
         [self.tagView addTag:tag];
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

- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    
    
    [self.view endEditing:YES];
    
    
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


-(void)searchWithKeyword:(NSString *)keyword
{

    
    if ([_searchBar isFirstResponder]) {
        
        [_searchBar resignFirstResponder];
        
        
    }
    

    _collectionBg.hidden=NO;

    searchResult.mKeyword=keyword;
    
    
    [searchResult refreshData];








}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
        if ([searchText isEqualToString:@""]) {
            self.collectionBg.hidden=YES;
        }else
        {
            
            self.collectionBg.hidden=NO;
            
        }

    
    } completion:nil];
    
    

   
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{


    [self searchWithKeyword:searchBar.text];
    
    
    
    
}
@end

//
//  EZSearchViewController.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/11.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
#import "EZCollectionVC.h"
@interface EZSearchViewController : UIViewController<UISearchBarDelegate>
{

    NSMutableArray *mKeywords;

    EZCollectionVC *searchResult;

}
@property (strong, nonatomic) SKTagView *tagView;
@property (nonatomic, strong) NSArray *colorPool;
@property (weak, nonatomic) IBOutlet UIView *keywordsView;
- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender;
- (IBAction)backButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *contentBg;
@property (weak, nonatomic) IBOutlet UIView *collectionBg;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

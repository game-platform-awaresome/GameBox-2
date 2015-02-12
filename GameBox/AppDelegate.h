//
//  AppDelegate.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,GADInterstitialDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain,nonatomic)NSString *updateUrl;//版本更新
@property(retain,nonatomic)NSString *mAppAlertGoUrl;//评分


@property (nonatomic, strong)GADInterstitial *interstitial;
@end


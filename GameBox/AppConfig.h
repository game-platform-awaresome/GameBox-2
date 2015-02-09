//
//  AppConfig.h
//  MyContacts
//
//  Created by 赵 进喜 on 15/1/20.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#ifndef GameBox_AppConfig_h
#define GameBox_AppConfig_h

#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define BUNDLEID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define IS_IOS7 (BOOL)([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0 ? YES : NO)
#define IS_IOS8 (BOOL)([[[UIDevice currentDevice] systemVersion]floatValue]>=8.0 ? YES : NO)


#define APP_ID @"945962817"

#define APP_URL @"https://itunes.apple.com/cn/app/id945962817?mt=8"


#define UMENG_APP_ID @"54d43d71fd98c557e4000dab"
#define UMENG_APP_SHARE_ID @"52da412756240b498805ec08"
#define ADMOB_APP_ID @"ca-app-pub-6780489147196436/9197691505"
#define ADMOB_SCREEN_APP_ID @"ca-app-pub-6780489147196436/1674424708"



#define UID [[NSUserDefaults standardUserDefaults]valueForKey:@"uid"]


#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#endif
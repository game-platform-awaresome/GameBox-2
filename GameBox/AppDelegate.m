//
//  AppDelegate.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/9.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "AppDelegate.h"
#import <AdSupport/AdSupport.h>
#import "ZipArchive.h"
#import "SVProgressHUD.h"
#import "APService.h"
#import "MobClick.h"
#import "Reachability.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()
{


    Reachability *hostReach;;}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    NSString *idfa=[[[ASIdentifierManager sharedManager] advertisingIdentifier]UUIDString];
    [[NSUserDefaults standardUserDefaults]setValue:idfa forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"URLCACHE" ofType:@"zip"];
    
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *folder=[cachePath stringByAppendingPathComponent:@"URLCACHE"];
    NSString *filePath=[cachePath stringByAppendingPathComponent:@"URLCACHE.zip"];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:folder]) {
        
        
        [data writeToFile:filePath atomically:YES];
        
        
        [self unZipAtPath:filePath WithFolderPath:cachePath];
    }
    
     [self checkNetwork];
    
    
    [MobClick startWithAppkey:UMENG_APP_ID reportPolicy:BATCH channelId:@"App Store"];
    
    [MobClick setVersion:[VERSION integerValue]];

    
    NSLog(@"%@",cachePath);

    
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        
    }else
    {
        
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
        
    }
    
    
    
    
    
#else
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    
#endif
    
    
    
    [APService setupWithOption:launchOptions];
    
    [self umSocial];

    
    //请求后台控制
    
    [self  requests];

    
    
    return YES;
}
-(void)unZipAtPath:(NSString *)zipPath WithFolderPath:(NSString *)folderPath
{
    
    ZipArchive *zip=[[ZipArchive alloc]init];
    
    
    
    ;
    if ([zip UnzipOpenFile:zipPath]) {
        
        
        
        [zip UnzipFileTo:folderPath overWrite:YES];
        
        
        [zip UnzipCloseFile];
    }
   
    
    
}
- (void)umSocial{
    [UMSocialData setAppKey:UMENG_APP_SHARE_ID];
    //设置微信AppId，url地址传nil，将默认使用友盟的网址
    NSString * string= [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APP_ID];
    // [UMSocialWechatHandler setWXAppId:@"wx12815c3885327d6a" url:string];
    
    [UMSocialWechatHandler setWXAppId:@"wx12815c3885327d6a" appSecret:@"bfc284340b6fcd09afe9762d95f12aa6" url:string];
    
    
    [UMSocialData defaultData].extConfig.title = @"蜂狂连消";
    
    //设置手机QQ的AppId，url传nil，将使用友盟的网址
    
}

//检测网络
-(void)checkNetwork
{
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    
    
    
    
    
    
    [hostReach startNotifier];
    
    
    
}


- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告!" message:@"网络无法连接，部分功能可能无法体验" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        
        alert.tag=1004;
        
        [alert show];
        
    }
}


- (void)requests{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        return;
    }
    
    
    __block  NSDictionary *item=[NSDictionary dictionary];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://93app.com/gonglue_xilie/ping.php?id=%@&version=%@",BUNDLEID,VERSION]];
        NSLog(@"neitui:%@",url);
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (data) {
            item = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }else{
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            if ([[item objectForKey:@"status"]intValue]==1) {
                
                
                
                if ([[item objectForKey:@"in_control"]intValue]==0) {
                    
                    
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isPassed"];
                    
                    
                    
                    [[NSUserDefaults standardUserDefaults]setObject:item[@"ad_banner"] forKey:@"adtype"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    
                    //版本更新
                    if (![[item objectForKey:@"update_url"] isEqualToString:@""]) {
                        
                        
                        [self updateAppWithStrUrl:[item objectForKey:@"update_url"]];
                        
                        
                        
                    }
                    
                    //内推
                    //  if (![AppUtil productWasPurchased]) {
                    [self performSelector:@selector(getAppInfo:) withObject:item afterDelay:15];
                    
                    
                    
                    //谷歌广告
                    int interval=[[item objectForKey:@"big_ad_interval"]intValue];
                    
                    if (interval>0) {
                        if (interval<10) {
                            interval=60;
                        }
                        [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(loadFullScreenAd) userInfo:nil repeats:YES];
                        
                    }
                    
                    //  }
                    
                    
                    
                    //评分
                    
                    [self performSelector:@selector(makeScore) withObject:self afterDelay:30];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        });
    });
}





// 版本更新
-(void)updateAppWithStrUrl:(NSString *)strUrl
{
    
    _updateUrl=strUrl;
    
    
    //    NSLog(@"aaahahahha%@",strUrl);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"更新提示" message:@"新版发布了，不要错过哦" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"更新", nil];
    alert.tag=1003;
    [alert show];
    
    
    
    
}


//内推
- (void)getAppInfo:(NSDictionary *)item {
    
    
    
    int lastInterval=[[NSUserDefaults standardUserDefaults]floatForKey:@"lasttime"];
    
    NSDate *nowDate=[NSDate date];
    
    int nowInterval=[nowDate timeIntervalSince1970];
    [[NSUserDefaults standardUserDefaults]setInteger:nowInterval forKey:@"lasttime"];
    
    if (nowInterval-lastInterval>=3600*12*1) {
        
        
        [self checkAppConf:item];
        
    }
    
}

- (void)checkAppConf:(NSDictionary *)item {
    
    
    
    //NSLog(@"%@",item);
    UIAlertView *alert;
    
    
    if ([[item objectForKey:@"status"]intValue]==1) {
        
        
        NSArray *ads=[item objectForKey:@"neitui_list"];
        
        if ([ads isKindOfClass:[NSArray class]]) {
            NSDictionary *ad=[ads objectAtIndex:0];
            //  NSLog(@"ad:%@",item);
            
            
            
            
            //如果已经安装，则不提示
            //mAppAlertGoUrl = [[item objectForKey:@"itunes_url"] copy];
            
            // NSLog(@" hahahahah%@",mAppAlertGoUrl);
            NSString *scheme = [ad objectForKey:@"url_scheme"];
            
            
            // NSLog(@"scheme:%@",scheme);
            
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://",scheme]];
            if (![[UIApplication sharedApplication] canOpenURL:url]) {
                
                _mAppAlertGoUrl=[ad objectForKey:@"url"];
                
                
                alert = [[UIAlertView alloc] initWithTitle:[ad objectForKey:@"headline"] message:[ad objectForKey:@"description"]
                                                  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
                alert.tag = 1001;
                alert.delegate = self;
                [alert show];
            }else{
                
                ad=[ads objectAtIndex:1];
                NSString *scheme = [ad objectForKey:@"url_scheme"];
                
                // NSLog(@"scheme:%@",scheme);
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://",scheme]];
                if (![[UIApplication sharedApplication] canOpenURL:url]) {
                    
                    _mAppAlertGoUrl=[ad objectForKey:@"url"];
                    
                    alert = [[UIAlertView alloc] initWithTitle:[ad objectForKey:@"headline"] message:[ad objectForKey:@"description"]
                                                      delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
                    alert.tag = 1001;
                    alert.delegate = self;
                    [alert show];
                    
                }
                
                
            }
            
            
        }
        
    }
    
    
    
    
}






-(void)makeScore
{
    
    BOOL scored=[[NSUserDefaults standardUserDefaults]boolForKey:@"scored"];
    if (!scored) {
        
        
        
        int lastInterval=[[NSUserDefaults standardUserDefaults]floatForKey:@"P_lasttime"];
        
        NSDate *nowDate=[NSDate date];
        
        int nowInterval=[nowDate timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults]setInteger:nowInterval forKey:@"P_lasttime"];
        
        if (nowInterval-lastInterval>3600*12*2) {
            
            
            
            //NSLog(@"去给我评个分吧%d  ~~~~~~~~  %d",nowInterval,lastInterval);
            
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"给我评分" message:@"快给我五星好评吧！！" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"现在就去", nil];
            alert.tag=1002;
            [alert show];
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    
}




-(void)loadFullScreenAd
{
    
    NSString *type=[[NSUserDefaults standardUserDefaults]objectForKey:@"adtype"];
    
    
    
    if ([type isEqualToString:@"gdt"]) {
        
        
        
        
    }else
    {
        
        
        self.interstitial = [[GADInterstitial alloc]init];
        self.interstitial.delegate=self;
        self.interstitial.adUnitID =ADMOB_SCREEN_APP_ID;
        [self.interstitial loadRequest:[GADRequest request]];
        
    }
    
    
    
    
    
}
//admob
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    
    
    [self.interstitial presentFromRootViewController:self.window.rootViewController];
}


- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    
    
    
    NSLog(@"%@",error);
    
    
}








- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    switch (alertView.tag) {
            
            
        case 1001:
            
            
            if (buttonIndex==1) {
                
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_mAppAlertGoUrl]];
                
                
            }
            
            break;
        case 1002:
            
            
            if (buttonIndex==1) {
                
                
                
                
                
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"scored"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:APP_URL]];
                
                
                
            }
            
            break;
        case 1003:
            
            
            if (buttonIndex==1) {
                
                
                //NSLog(@"%d",buttonIndex);
                
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_updateUrl]];
                
                
                
            }
            
            break;
            
            
            
        default:
            break;
    }
    
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UMSocialSnsService  applicationDidBecomeActive];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 极光推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}
//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"this is iOS7 Remote Notification");
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field =[%@]",content,(long)badge,sound,customizeField1);
    // Required
    
    // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:content]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}


@end

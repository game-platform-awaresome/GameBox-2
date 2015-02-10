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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    
    
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
    
    
    
    
    
    
    NSLog(@"%@",cachePath);

    
    
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

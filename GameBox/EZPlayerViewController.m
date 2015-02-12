//
//  EZPlayerViewController.m
//  GameBox
//
//  Created by 赵 进喜 on 15/2/10.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZPlayerViewController.h"
#import <AdSupport/AdSupport.h>
#import "CustomURLCache.h"
#import "UMSocial.h"
@interface EZPlayerViewController ()

@end

@implementation EZPlayerViewController
-(id)initWithCoder:(NSCoder *)aDecoder
{

    if (self =[super initWithCoder:aDecoder]) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];

    }


    return self;

}
-(void)viewWillDisappear:(BOOL)animated
{


    [super viewWillDisappear:animated];
    
    
    
    [mPlayer stop];


}

-(void)dealloc
{

    self.webView=nil;
    
    
    if (mPlayer) {
        
        
        [mPlayer stop];
        
        
        mPlayer=nil;

        
    }
    
   

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
  
    
    self.webView.scrollView.bounces=NO;
    
  
    
    gameUrl=[_myItem objectForKey:@"play_url"];
    
    
    
    if ([_myItem objectForKey:@"sound"]&&![[_myItem objectForKey:@"sound"] isEqualToString:@""]) {
        
        
        
        [self playMusicWithData];
        
        
        
    }
    
    
    
    
    
    
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:gameUrl]]];

    jsString=[NSString stringWithContentsOfURL:[NSURL URLWithString:[_myItem objectForKey:@"proc"]] encoding:NSUTF8StringEncoding error:nil];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    
    
    
    self.navigationController.navigationBarHidden=YES;



}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *str=[request.URL absoluteString];
    
    if (![str isEqualToString:gameUrl]) {
        return NO;
    }
    
    
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{



    if (jsString) {
        [_webView stringByEvaluatingJavaScriptFromString:jsString];
    }





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

- (IBAction)backToLast:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)playMusicWithData
{





    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    
        
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[_myItem objectForKey:@"sound"]]];
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        
            mPlayer=[[AVAudioPlayer alloc]initWithData:data error:nil];
            
            mPlayer.delegate=self;
            [mPlayer prepareToPlay];
            [mPlayer play];
            
            
        
        
        
        
        });
    
    
    
    
    
    
    });







}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{


    if (flag) {
        
        
        [player play];
        
    }
    



}
- (IBAction)shareTo:(UIButton *)sender {
    
    
    NSString * content = [NSString stringWithFormat:@"%@，年度最好玩的小游戏，打发时间必备，快来玩吧。\r\n%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"],[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APP_ID]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_APP_SHARE_ID
                                      shareText:content
                                     shareImage:[UIImage imageNamed:@"Icon-60@3x"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms,UMShareToEmail,nil]
                                       delegate:nil];
    [UMSocialData defaultData].extConfig.title = @"蜂狂连消";
    
    
    
    
    
}

@end

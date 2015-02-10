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
-(void)dealloc
{

    self.webView=nil;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
  
    
    
    
  
    
    gameUrl=[_myItem objectForKey:@"play_url"];
    
    
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
@end

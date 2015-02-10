//
//  EZPlayerViewController.h
//  GameBox
//
//  Created by 赵 进喜 on 15/2/10.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZPlayerViewController : UIViewController<UIWebViewDelegate>
{

    NSString *gameUrl;
    
    NSString *jsString;

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)NSDictionary *myItem;
- (IBAction)backToLast:(UIButton *)sender;
@end

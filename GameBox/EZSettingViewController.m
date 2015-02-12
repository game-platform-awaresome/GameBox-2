//
//  EZSettingViewController.m
//  MyContacts
//
//  Created by 赵 进喜 on 15/2/4.
//  Copyright (c) 2015年 everzones. All rights reserved.
//

#import "EZSettingViewController.h"
#import<MessageUI/MFMailComposeViewController.h>
#import "SVProgressHUD.h"
#import "EZCollectionVC.h"
#import "EZAppHelper.h"
@interface EZSettingViewController ()<MFMailComposeViewControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation EZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.versionLabel.text=VERSION;
    
   
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    if (indexPath.section==0) {
        
        
        UICollectionViewFlowLayout * Layout=[[UICollectionViewFlowLayout alloc]init];
        
        Layout.itemSize=CGSizeMake((SCREEN_WIDTH-16)/2, 102);
        Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        Layout.minimumInteritemSpacing=2;
        Layout.minimumLineSpacing=2;
        
        
        Layout.sectionInset=UIEdgeInsetsMake(7, 7, 7, 7);
        
        
      EZCollectionVC *  newCollection=[[EZCollectionVC alloc]initWithCollectionViewLayout:Layout AndType:EZCollectionTypeLoved];
        
     
        [self.navigationController pushViewController:newCollection animated:YES];
        
        
        
    }else if (indexPath.section==1) {
        
        
        if (indexPath.row==2) {
            
            
            
            [self showMailPicker];
            
            
            
        }else if (indexPath.row==3)
        {
        
        
        
            NSString *url=APP_URL;
            
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];

        
        
        }else if (indexPath.row==0)
        {
        
        
            
            //清除UIWebView的缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
        
        
            
            
            [SVProgressHUD showSuccessWithStatus:@"缓存清除成功！"];
        
        }else if (indexPath.row==1)
        {
        
        
        
            [[EZAppHelper shareAppHelper].history_record removeAllObjects];
            
            [[EZAppHelper shareAppHelper]saveItemsToFile:[EZAppHelper shareAppHelper].history_record cacheId:@"history"];
            
            
            
             [[NSNotificationCenter defaultCenter]postNotificationName:@"remove" object:nil];
            
            
            
             [SVProgressHUD showSuccessWithStatus:@"关注清除成功！"];
           

        
        
        }
        
        
        
        
    }
    
    
    
    
    
    

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];


}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)showMailPicker{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil){
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail]){
            [self displayComposerSheet];
        }else{
            [self launchMailAppOnDevice];
        }
    }else{
        [self launchMailAppOnDevice];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)launchMailAppOnDevice
{
    
}
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:[NSArray arrayWithObject:@"support@93app.com"]];
    [picker setSubject:@"意见反馈- 蜂狂连消"];
    picker.title = @"意见反馈";
    //[picker setMessageBody:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
}







- (IBAction)backButtonPressed:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end

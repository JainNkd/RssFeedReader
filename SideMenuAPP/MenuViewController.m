//
//  MenuViewController.m
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/12/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import "MenuViewController.h"
#import "Menu1ViewController.h"
#import "Menu2ViewController.h"
#import "Menu3ViewController.h"
#import "LoginViewController.h"
#import "CustomOrientationNavigationController.h"
#import "RootViewController.h"

#import "AppDelegate.h"

@interface MenuViewController ()
{
    NSMutableArray *menuArr;
}

@end

@implementation MenuViewController
@synthesize menuTableViewObj;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuArr = [NSMutableArray arrayWithObjects:@"+ Add Feeds",@"Yahoo News Rss",@"Tech News Rss",@"Iphone Development",@"Life Style",@"LOG OUT", nil];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.menuTableViewObj selectRowAtIndexPath:SharedAppDelegate.selectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];

}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_IDENTIFIER = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    cell.textLabel.text = [menuArr objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.menuTableViewObj.frame.size.width,100)];
    headerview.backgroundColor = [UIColor brownColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,20,60,60)];
    [imageView setImage:[UIImage imageNamed:@"images.png"]];
    imageView.layer.cornerRadius = 30;
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.masksToBounds = NO;
    imageView.clipsToBounds = YES;
    
    UILabel *userNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(100,40,200,25)];
    userNameLbl.text = @"Naveen Kumar";
    userNameLbl.textColor = [UIColor whiteColor];
    [headerview addSubview:userNameLbl];
    
    [headerview addSubview:imageView];
    
    return headerview;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SharedAppDelegate.selectedIndex = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 1)
    {
        [self showselectedMenuView:@"Menu1ViewController"];
    }
    else if (indexPath.row == 2)
    {
        [self showselectedMenuView:@"Menu2ViewController"];
    }
    else if (indexPath.row == 3)
    {
        [self showselectedMenuView:@"Menu3ViewController"];
    }
    else if (indexPath.row == 4)
    {
        [self showselectedMenuView:@"Menu4ViewController"];
    }
    else if(indexPath.row == 5)
    {
        NSUserDefaults *defualt = [NSUserDefaults standardUserDefaults];
        [defualt setBool:NO forKey:@"LOGIN_USER"];
        LoginViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        UINavigationController *navBar=[[CustomOrientationNavigationController alloc] initWithRootViewController:loginView withSupportedOrientations:(UIInterfaceOrientationMaskPortrait)];
        [self presentViewController:navBar animated:YES completion:nil];
    }
}

-(void)showselectedMenuView:(NSString*)viewIdentifier
{
         self.viewDeckController.leftController = SharedAppDelegate.leftController;
         
         UIViewController* selectedController = [self.storyboard instantiateViewControllerWithIdentifier:viewIdentifier];
         UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:selectedController];
         
         self.viewDeckController.centerController = navController;
        [self.viewDeckController closeLeftViewAnimated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

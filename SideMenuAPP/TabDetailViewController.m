//
//  TabDetailViewController.m
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/19/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import "TabDetailViewController.h"

@interface TabDetailViewController ()

@end

@implementation TabDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTabs:)];
    
    self.title = [userDefault valueForKey:@"TAB_TITLE"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNewTabs:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Add Tiles" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"CHART",
                            @"MARKET REPORT",
                            @"NOTES",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

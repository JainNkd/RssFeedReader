//
//  Menu3ViewController.m
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/12/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import "Menu3ViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "RSSEntry.h"

@interface Menu3ViewController ()
{
    NSMutableArray *tabsArr;
}
@end

@implementation Menu3ViewController

- (void)viewDidLoad {
    
    self.feeds = [NSArray arrayWithObjects:@"http://iphonedevelopment.blogspot.com/feeds/posts/default",nil];
    
    [super viewDidLoad];
    
    self.title = @"Iphone Developement";
    // Do any additional setup after loading the view.
}

-(void)reloadTable
{
    [self.rssFeedsTableViewObj reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allEntries count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_IDENTIFIER = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    
    RSSEntry *entry = [self.allEntries objectAtIndex:indexPath.row];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *articleDateString = [dateFormatter stringFromDate:entry.articleDate];
    
    cell.textLabel.text = entry.articleTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, entry.blogTitle];
    return cell;
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

- (IBAction)nextMenuButtonPressed:(UIButton *)sender {
    [self showselectedMenuView:@"Menu4ViewController"];
}

-(void)showselectedMenuView:(NSString*)viewIdentifier
{

    self.viewDeckController.leftController = SharedAppDelegate.leftController;
    
    UIViewController* selectedController = [self.storyboard instantiateViewControllerWithIdentifier:viewIdentifier];
    [self.viewDeckController rightViewPushViewControllerOverCenterController:selectedController];

}
@end

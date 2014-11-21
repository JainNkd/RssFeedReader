//
//  Menu1ViewController.m
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/12/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import "Menu1ViewController.h"
#import "IIViewDeckController.h"
#import "TabDetailViewController.h"
#import "RSSEntry.h"
#import "WebViewController.h"

@interface Menu1ViewController ()
{
    NSMutableArray *tabsArr;
}
@end

@implementation Menu1ViewController
@synthesize rssFeedsTableViewObj;
- (void)viewDidLoad {
    
    self.feeds = [NSArray arrayWithObjects:@"http://news.yahoo.com/rss/",
                  nil];
    [super viewDidLoad];

    self.title = @"Yahoo News Feeds";
    NSLog(@"all entries...%@",[self.allEntries description]);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allEntries count];
}

-(void)reloadTable
{
    [self.rssFeedsTableViewObj reloadData];
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

-(void)addNewTabs:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"NEW TAB" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [av textFieldAtIndex:0];
    [textField setPlaceholder:@"Enter Tab Name"];

    [av textFieldAtIndex:0].delegate = self;
    [av show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_webViewController == nil) {
        self.webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle]];
    }
    RSSEntry *entry = [_allEntries objectAtIndex:indexPath.row];
    _webViewController.entry = entry;
    [self.navigationController pushViewController:_webViewController animated:YES];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    NSLog(@"Text values:...%@",textField.text);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Text values:...%@",textField.text);
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

@end

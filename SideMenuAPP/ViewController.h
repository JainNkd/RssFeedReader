//
//  ViewController.h
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/12/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface ViewController : UIViewController
{
    NSOperationQueue *_queue;
    NSArray *_feeds;
    NSMutableArray *_allEntries;
    WebViewController *_webViewController;
}

@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;
@property (retain) NSMutableArray *allEntries;
@property (retain) WebViewController *webViewController;

-(void)reloadTable;
@end


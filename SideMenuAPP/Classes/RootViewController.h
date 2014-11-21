//
//  RootViewController.h
//  RSSFun
//
//  Created by Ray Wenderlich on 1/24/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface RootViewController : UITableViewController {
    NSOperationQueue *_queue;
    NSArray *_feeds;
    NSMutableArray *_allEntries;
    WebViewController *_webViewController;
}

@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;
@property (retain) NSMutableArray *allEntries;
@property (retain) WebViewController *webViewController;

@end

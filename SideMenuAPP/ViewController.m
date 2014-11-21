//
//  ViewController.m
//  SideMenuAPP
//
//  Created by Naveen Kumar Dungarwal on 11/12/14.
//  Copyright (c) 2014 Naveen Kumar Dungarwal. All rights reserved.
//

#import "ViewController.h"
#import "IIViewDeckController.h"

#import "RSSEntry.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
#import "NSDate+InternetDateTime.h"
#import "NSArray+Extras.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize allEntries = _allEntries;
@synthesize feeds = _feeds;
@synthesize queue = _queue;
@synthesize webViewController = _webViewController;


- (void)refresh {
    
    for (NSString *feed in _feeds) {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [_queue addOperation:request];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Feeds";
    self.allEntries = [NSMutableArray array];
    self.queue = [[NSOperationQueue alloc] init];
    [self refresh];

    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels) {
        
        NSString *blogTitle = [channel valueForChild:@"title"];
        
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items) {
            
            NSString *articleTitle = [item valueForChild:@"title"];
            NSString *articleUrl = [item valueForChild:@"link"];
            NSString *articleDateString = [item valueForChild:@"pubDate"];
            NSDate *articleDate = [NSDate dateFromInternetDateTimeString:articleDateString formatHint:DateFormatHintRFC822];
            
            RSSEntry *entry = [[RSSEntry alloc] initWithBlogTitle:blogTitle
                                                      articleTitle:articleTitle
                                                        articleUrl:articleUrl
                                                       articleDate:articleDate];
            [entries addObject:entry];
            
        }
    }
}

- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSString *blogTitle = [rootElement valueForChild:@"title"];
    
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items) {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];
        for(GDataXMLElement *link in links) {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue];
            if ([rel compare:@"alternate"] == NSOrderedSame &&
                [type compare:@"text/html"] == NSOrderedSame) {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        NSString *articleDateString = [item valueForChild:@"updated"];
        NSDate *articleDate = [NSDate dateFromInternetDateTimeString:articleDateString formatHint:DateFormatHintRFC3339];
        
        RSSEntry *entry = [[RSSEntry alloc] initWithBlogTitle:blogTitle
                                                  articleTitle:articleTitle
                                                    articleUrl:articleUrl
                                                   articleDate:articleDate];
        [entries addObject:entry];
        
    }
    
}

- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    if ([rootElement.name compare:@"rss"] == NSOrderedSame) {
        [self parseRss:rootElement entries:entries];
    } else if ([rootElement.name compare:@"feed"] == NSOrderedSame) {
        [self parseAtom:rootElement entries:entries];
    } else {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    [_queue addOperationWithBlock:^{
        
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[request responseData]
                                                               options:0 error:&error];
        if (doc == nil) {
            NSLog(@"Failed to parse %@", request.url);
        } else {
            
            NSMutableArray *entries = [NSMutableArray array];
            [self parseFeed:doc.rootElement entries:entries];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                for (RSSEntry *entry in entries) {
                    
                    int insertIdx = [_allEntries indexForInsertingObject:entry sortedUsingBlock:^(id a, id b) {
                        RSSEntry *entry1 = (RSSEntry *) a;
                        RSSEntry *entry2 = (RSSEntry *) b;
                        return [entry1.articleDate compare:entry2.articleDate];
                    }];
                    
                    [_allEntries insertObject:entry atIndex:insertIdx];
                    [self reloadTable];
//                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]]
//                                          withRowAnimation:UITableViewRowAnimationRight];
                    
                }
                
            }];
            
        }
    }];
    
}

-(void)reloadTable
{
    
    
}


- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

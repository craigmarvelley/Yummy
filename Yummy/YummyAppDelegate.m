//
//  YummyAppDelegate.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/YAJL/RKJSONParserYAJL.h>

#import "YummyAppDelegate.h"
#import "RootViewController.h"
#import "RecentBookmarksController.h"
#import "Bookmark.h"

@interface YummyAppDelegate (Private) 
    - (void)initRestKit;
@end

@implementation YummyAppDelegate


@synthesize window=_window;

@synthesize splitViewController=_splitViewController;

@synthesize rootViewController=_rootViewController;

@synthesize recentBookmarksController=_recentBookmarksController;

@synthesize rootPopoverButtonItem;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initRestKit];
    
    // Override point for customization after application launch.
    // Add the split view controller's view to the window and display.
    self.splitViewController =[[UISplitViewController alloc] init];
	self.rootViewController=[[RootViewController alloc] init];
	self.recentBookmarksController=[[RecentBookmarksController alloc] init];
    
	UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:self.rootViewController];
    UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:self.recentBookmarksController];
    
	self.splitViewController.viewControllers=[NSArray arrayWithObjects:rootNav,detailNav,nil];
	self.splitViewController.delegate=self.recentBookmarksController;
    
    [rootNav release];
    [detailNav release];
    
    // Add the split view controller's view to the window and display.
    [_window addSubview:self.splitViewController.view];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)initRestKit
{
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://feeds.delicious.com/v2/json"];

    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserYAJL class] forMIMEType:@"text/html"]; 
    
    // Enable automatic network activity indicator management
    [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
    
    // Delicious won't respond with a valid request without a proper user agent
    [[RKClient sharedClient] setValue: @"Yummy" forHTTPHeaderField:@"User-Agent"];

    // Set up object mappings
    RKObjectMapping* bookmarkMapping = [RKObjectMapping mappingForClass:[Bookmark class]];
    [bookmarkMapping mapKeyPath:@"u" toAttribute:@"url"];
    [bookmarkMapping mapKeyPath:@"d" toAttribute:@"title"];
    [bookmarkMapping mapKeyPath:@"t" toAttribute:@"tags"];
    
    [objectManager.mappingProvider setMapping:bookmarkMapping forKeyPath:@"bookmark"];
}

- (void)dealloc
{
    [_window release];
    [_splitViewController release];
    [_rootViewController release];
    [_recentBookmarksController release];
    [rootPopoverButtonItem release];
    [super dealloc];
}

@end

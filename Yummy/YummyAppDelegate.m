//
//  YummyAppDelegate.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "YummyAppDelegate.h"

#import "RootViewController.h"
#import "RecentBookmarksController.h"

@implementation YummyAppDelegate


@synthesize window=_window;

@synthesize splitViewController=_splitViewController;

@synthesize rootViewController=_rootViewController;

@synthesize RecentBookmarksController=_RecentBookmarksController;

@synthesize rootPopoverButtonItem;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the split view controller's view to the window and display.
    self.splitViewController =[[UISplitViewController alloc] init];
	self.rootViewController=[[RootViewController alloc] init];
	self.RecentBookmarksController=[[RecentBookmarksController alloc] init];
    
	UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:self.rootViewController];
    UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:self.RecentBookmarksController];
    
	self.splitViewController.viewControllers=[NSArray arrayWithObjects:rootNav,detailNav,nil];
	self.splitViewController.delegate=self.RecentBookmarksController;
    
    [rootNav release];
    [detailNav release];
    
    // Add the split view controller's view to the window and display.
    [_window addSubview:self.splitViewController.view];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_splitViewController release];
    [_rootViewController release];
    [_RecentBookmarksController release];
    [rootPopoverButtonItem release];
    [super dealloc];
}

@end

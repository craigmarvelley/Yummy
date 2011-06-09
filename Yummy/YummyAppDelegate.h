//
//  YummyAppDelegate.h
//  Yummy
//
//  Created by Craig on 09/06/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class RecentBookmarksController;

@interface YummyAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    RecentBookmarksController *RecentBookmarksController;
	UIBarButtonItem *rootPopoverButtonItem;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain)  UISplitViewController *splitViewController;
@property (nonatomic, retain)  RootViewController *rootViewController;
@property (nonatomic, retain)  RecentBookmarksController *RecentBookmarksController;
@property (nonatomic, assign)  UIBarButtonItem *rootPopoverButtonItem;

@end
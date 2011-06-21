//
//  YummyAppDelegate.h
//  Yummy
//
//  Created by Craig on 09/06/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class RecentBookmarksViewController;

@interface YummyAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    RecentBookmarksViewController *defaultDetailController;
	UIBarButtonItem *rootPopoverButtonItem;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain)  UISplitViewController *splitViewController;
@property (nonatomic, retain)  RootViewController *rootViewController;
@property (nonatomic, retain)  RecentBookmarksViewController *defaultDetailController;
@property (nonatomic, assign)  UIBarButtonItem *rootPopoverButtonItem;

@end
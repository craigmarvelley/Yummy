//
//  YummyAppDelegate.h
//  Yummy
//
//  Created by Craig on 09/06/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class PopularBookmarksController;

@interface YummyAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    PopularBookmarksController *popularBookmarksController;
	UIBarButtonItem *rootPopoverButtonItem;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain)  UISplitViewController *splitViewController;
@property (nonatomic, retain)  RootViewController *rootViewController;
@property (nonatomic, retain)  PopularBookmarksController *popularBookmarksController;
@property (nonatomic, assign)  UIBarButtonItem *rootPopoverButtonItem;

@end
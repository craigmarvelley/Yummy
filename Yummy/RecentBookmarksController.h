//
//  RecentBookmarksController.h
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YummyAppDelegate.h"

@interface RecentBookmarksController : UITableViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> 
{
    UIPopoverController *popoverController;
	YummyAppDelegate *appDelegate;
}

@property (nonatomic, assign) YummyAppDelegate *appDelegate;
@property (nonatomic, assign) UIPopoverController *popoverController;


@end


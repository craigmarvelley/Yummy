//
//  PopularBookmarksController.h
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 BoxUK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YummyAppDelegate.h"

@interface PopularBookmarksController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> 
{
    UIPopoverController *popoverController;
	YummyAppDelegate *appDelegate;
}

@property (nonatomic, assign) YummyAppDelegate *appDelegate;
@property (nonatomic, assign) UIPopoverController *popoverController;


@end

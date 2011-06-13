//
//  DetailViewController.m
//  Yummy
//
//  Created by Craig on 12/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize popoverController;
@synthesize appDelegate;

-(id) init 
{
    self=[super init];
    
	if (self) 
    {
		self.appDelegate = (YummyAppDelegate *)[[UIApplication sharedApplication] delegate];
	}
	return self;
}

- (void)viewDidUnload 
{
    self.popoverController = nil;
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc 
{    
	barButtonItem.title = @"Root List";
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
	[self setPopoverController:pc];
	self.appDelegate.rootPopoverButtonItem = barButtonItem;
    
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem 
{
	[[self navigationItem] setLeftBarButtonItem:nil];
	[self setPopoverController:nil];
	self.appDelegate.rootPopoverButtonItem = barButtonItem;
}

#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{	
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
    {
		[[self navigationItem] setLeftBarButtonItem:nil];
	}
	else 
    {
		[[self navigationItem] setLeftBarButtonItem:self.appDelegate.rootPopoverButtonItem];
	}	
	return YES;
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [popoverController release];
    
    [super dealloc];
}


@end

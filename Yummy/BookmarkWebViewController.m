//
//  BookmarkWebViewController.m
//  Yummy
//
//  Created by Craig on 15/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookmarkWebViewController.h"


@implementation BookmarkWebViewController

@synthesize URL;
@synthesize webView;
@synthesize menuButton;

- (void)dealloc
{
    [URL release];
    [webView release];
    [menuButton release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.URL];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
    self.menuButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Popover handling

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.menuButton.enabled = YES;
}

- (IBAction)presentOptionPopover:(id)sender {
    
    self.menuButton.enabled = NO;
    
    UIViewController *controller = [[UIViewController alloc] init];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    popover.delegate = self;
    
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [controller release];
    
}

@end

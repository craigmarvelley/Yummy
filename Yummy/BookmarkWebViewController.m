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
@synthesize popoverActionSheet;

- (void)dealloc
{
    [URL release];
    [webView release];
    [menuButton release];
    [popoverActionSheet release];
    
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
	return YES;
}

#pragma mark -
#pragma mark Action methods

- (void)openBookmarkInSafari
{
    [[UIApplication sharedApplication] openURL:self.URL];
}

#pragma mark Mail compose sheet delegate methods

-(void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set subject
    [picker setSubject:@"Check out this link!"];
        
    // Set body
    NSString *emailBody = [self.URL absoluteString];
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentModalViewController:picker animated:YES];
    
    [picker release];
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Action sheet popover handling

- (IBAction)presentOptionPopover:(id)sender {
    
    //If the actionsheet is visible it is dismissed, if it not visible a new one is created.
    if ([popoverActionSheet isVisible]) {
        
        [popoverActionSheet dismissWithClickedButtonIndex:[popoverActionSheet cancelButtonIndex] animated:YES];
        return;
    }
    
    popoverActionSheet = [[UIActionSheet alloc] 
                          initWithTitle:nil 
                          delegate:self
                          cancelButtonTitle:nil
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"Open in Safari", @"Tweet link", @"Email link", @"Copy URL", nil];
    
    [popoverActionSheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [actionSheet cancelButtonIndex]) 
    {
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            [self openBookmarkInSafari];
            break;
            
        case 1:
            break;
            
        case 2:
            [self displayMailComposerSheet];
            
        default:
            break;
    }
    
}

#pragma mark -
#pragma Done button handling

- (IBAction)dismissView:(id)sender {
    if([popoverActionSheet isVisible]) {
        [popoverActionSheet dismissWithClickedButtonIndex:[popoverActionSheet cancelButtonIndex] animated:NO];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}


@end

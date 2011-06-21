//
//  BookmarkCell.m
//  Yummy
//
//  Created by Craig on 14/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookmarkCell.h"
#import "TagSelectorViewController.h"


@implementation BookmarkCell

@synthesize tags, titleLabel, tagsLabel, tagsButton;

- (void)dealloc
{
    [tags release];
    [titleLabel release];
    [tagsLabel release];
    [tagsButton release];
    
    [super dealloc];
}

- (IBAction)tagsTouched:(id)sender
{
    TagSelectorViewController *tagsController = [[TagSelectorViewController alloc] initWithTags:self.tags];
    UINavigationController *container = [[UINavigationController alloc] initWithRootViewController:tagsController];
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:container];
    [popoverController presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [tagsController release];
    [container release];
}

@end

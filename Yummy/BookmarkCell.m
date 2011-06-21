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
    TagSelectorViewController *tagsTable = [[TagSelectorViewController alloc] init];
    tagsTable.tags = self.tags;
    
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:tagsTable];
    [popoverController presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [tagsTable release];
}

@end

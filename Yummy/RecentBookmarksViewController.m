//
//  RecentBookmarksViewController.m
//  Yummy
//
//  Created by Craig on 21/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecentBookmarksViewController.h"


@implementation RecentBookmarksViewController

- (void)loadView 
{
	self.title = @"Recent Bookmarks";
    self.feedUrl = [[NSURL alloc] initWithString:@"/recent"];
    
    [super loadView];
}

@end

//
//  PopularBookmarksController.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "PopularBookmarksViewController.h"
#import "RootViewController.h"

@implementation PopularBookmarksViewController

- (void)loadView 
{
	self.title = @"Popular Bookmarks";
    self.feedUrl = [[NSURL alloc] initWithString:@"/"];
    
    [super loadView];
}

@end

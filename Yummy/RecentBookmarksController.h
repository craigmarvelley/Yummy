//
//  RecentBookmarksController.h
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DetailViewController.h"
#import "Bookmark.h"

@interface RecentBookmarksController : DetailViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
    UITableView *_tableView;
	NSArray *_bookmarks;
}

@end


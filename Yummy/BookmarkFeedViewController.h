//
//  BookmarkFeedViewController.h
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DetailViewController.h"
#import "Bookmark.h"

@interface BookmarkFeedViewController : DetailViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate,
 UIPopoverControllerDelegate>
{
    UITableView *bookmarkTableView;
	NSArray *bookmarks;
    NSURL *feedURL;
}

@property (nonatomic, retain) UITableView *bookmarkTableView;
@property (nonatomic, retain) NSArray *bookmarks;
@property (nonatomic, retain) NSURL *feedUrl;

@end


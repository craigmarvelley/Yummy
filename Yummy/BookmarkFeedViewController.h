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
#import "EGORefreshTableHeaderView.h"
#import "Bookmark.h"

@interface BookmarkFeedViewController : DetailViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate,
 UIPopoverControllerDelegate, EGORefreshTableHeaderDelegate>
{
    UITableView *bookmarkTableView;
	NSArray *bookmarks;
    NSURL *feedURL;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, retain) UITableView *bookmarkTableView;
@property (nonatomic, retain) NSArray *bookmarks;
@property (nonatomic, retain) NSURL *feedUrl;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end


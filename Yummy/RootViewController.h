//
//  RootViewController.h
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YummyAppDelegate;
@class PopularBookmarksViewController;
@class RecentBookmarksViewController;

@interface RootViewController : UIViewController <UITextFieldDelegate> 
{    
    YummyAppDelegate *appDelegate;
}

- (NSMutableArray *)createMenuHeaderArray;
- (NSDictionary *)createMenuOptionsArray;
- (UITableViewCell *)createSearchCellForTableView:(UITableView *)tableView;
- (UITableViewCell *)createLoginCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)createSimpleOptionCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath forOptionGroup:(NSString *)optionGroup;
- (BOOL)userIsLoggedIn;

@property (nonatomic, assign) YummyAppDelegate *appDelegate;

@property (nonatomic, retain) NSMutableArray *sectionHeaders;
@property (nonatomic, retain) NSDictionary *simpleOptions;

@end
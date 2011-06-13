//
//  RecentBookmarksController.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "RecentBookmarksController.h"
#import "RootViewController.h"

@interface RecentBookmarksController (Private)
    - (void)loadBookmarks;
@end

@implementation RecentBookmarksController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)loadView 
{
    [super loadView];
    
	// Setup View and Table View	
	self.title = @"Recent Bookmarks";
    
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;	
	
    self.view = _tableView;
    
	[self loadBookmarks];
}

#pragma mark -
#pragma mark Bookmark management

- (void)loadBookmarks {
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    RKObjectMapping* bookmarkMapping = nil;
    
    // Use JSON parser
    if ([objectManager.acceptMIMEType isEqualToString:RKMIMETypeJSON]) {
        bookmarkMapping = [objectManager.mappingProvider objectMappingForKeyPath:@"bookmark"];
    }
    
    [objectManager loadObjectsAtResourcePath:@"/" objectMapping:bookmarkMapping delegate:self];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	NSLog(@"Loaded bookmarks: %@", objects);    
	[_bookmarks release];
	_bookmarks = [objects retain];
	[_tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [_bookmarks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString* reuseIdentifier = @"Bookmark Cell";
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (nil == cell) 
    {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
	}
    
	cell.textLabel.text = [[_bookmarks objectAtIndex:indexPath.row] title];
    
	return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
    [_tableView release];
    [_bookmarks release];
    
    [super dealloc];
}

@end

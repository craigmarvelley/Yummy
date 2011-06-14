//
//  RecentBookmarksController.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "RecentBookmarksController.h"
#import "RootViewController.h"
#import "BookmarkCell.h"

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
    _tableView.rowHeight = 64;
	
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
	NSString* reuseIdentifier = @"BookmarkCell";
    
	BookmarkCell *cell = (BookmarkCell *)
        [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
	if (nil == cell) 
    {
		NSArray *topLevelObjects = [[NSBundle mainBundle]
                                    loadNibNamed:@"BookmarkCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (BookmarkCell *) currentObject;
            }
        }
	}
    
	cell.titleLabel.text = [[_bookmarks objectAtIndex:indexPath.row] title];
    
    // Add the tags in a pipe delimited list
    NSMutableString *tagLabelText = [[NSMutableString alloc] init];
    NSArray *tags = [[_bookmarks objectAtIndex:indexPath.row] tags];
    
    for(int i=0, n=[tags count]; i<n; i++)
    {        
        [tagLabelText appendString:[tags objectAtIndex:i]];
        
        if(i < [tags count] - 1)
        {
            [tagLabelText appendString:@" | "];
        }
    }
    
    cell.tagsLabel.text = tagLabelText;
    
    [tagLabelText release];
    
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

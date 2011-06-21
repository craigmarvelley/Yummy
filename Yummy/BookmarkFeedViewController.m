//
//  BookmarkFeedViewController.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "BookmarkFeedViewController.h"
#import "RootViewController.h"
#import "BookmarkWebViewController.h"
#import "BookmarkCell.h"

@interface BookmarkFeedViewController (Private)
    - (void)loadBookmarks;
@end

@implementation BookmarkFeedViewController

@synthesize bookmarkTableView = _bookmarkTableView;
@synthesize bookmarks = _bookmarks;
@synthesize feedUrl = _feedUrl;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)loadView 
{
    [super loadView];
    
	_bookmarkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
	_bookmarkTableView.dataSource = self;
	_bookmarkTableView.delegate = self;	
    _bookmarkTableView.rowHeight = 60;
	
    self.view = _bookmarkTableView;
    
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
    
    NSString *path = [self.feedUrl relativePath];
    
    [objectManager loadObjectsAtResourcePath:path objectMapping:bookmarkMapping delegate:self];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	NSLog(@"Loaded bookmarks: %@", objects);    
	[_bookmarks release];
	_bookmarks = [objects retain];
	[_bookmarkTableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark -
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
#pragma mark Table delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookmarkWebViewController *controller = [[BookmarkWebViewController alloc] init];
    
    controller.URL = [[_bookmarks objectAtIndex:indexPath.row] url];
    
    //[self.navigationController pushViewController:view animated:true];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:controller];
    
    navigationController.navigationBar.hidden = YES;
    
    [self presentModalViewController:navigationController animated:YES];
    
    [controller release];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
    [_bookmarkTableView release];
    [_bookmarks release];
    [_feedUrl release];
    
    [super dealloc];
}

@end

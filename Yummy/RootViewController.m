//
//  RootViewController.m
//  Yummy
//
//  Created by Craig on 31/05/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "RootViewController.h"

#import "RecentBookmarksViewController.h"
#import "PopularBookmarksViewController.h"

@implementation RootViewController

@synthesize appDelegate;

@synthesize sectionHeaders;
@synthesize simpleOptions;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

    self.appDelegate = (YummyAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create options first so headers can count rows
    NSDictionary *optionDict = [self createMenuOptionsArray];
    self.simpleOptions = optionDict;
    
    NSMutableArray *headerArray = [self createMenuHeaderArray];
    self.sectionHeaders = headerArray;
}

- (void)viewDidUnload
{
    self.sectionHeaders = nil;
    self.simpleOptions = nil;
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

#pragma mark -
#pragma mark Menu set-up

- (NSMutableArray *)createMenuHeaderArray
{   
    NSDictionary *searchHeaderDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      @"Search", @"Title", 
                                      [NSNumber numberWithInt:1], @"RowCount", 
                                      nil];
    
    NSDictionary *unauthHeaderDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      @"Delicious.com", @"Title", 
                                      [NSNumber numberWithInt:[[[self simpleOptions] objectForKey:@"Unauthenticated"] count]], @"RowCount", 
                                      nil];
    
    NSDictionary *toolsHeaderDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"Tools", @"Title", 
                                     [NSNumber numberWithInt:[[[self simpleOptions] objectForKey:@"Tools"] count]], @"RowCount", 
                                     nil];
    
    NSMutableArray *menuArray = [[[NSMutableArray alloc] initWithObjects:searchHeaderDict, unauthHeaderDict, toolsHeaderDict, nil] autorelease];
    
    NSDictionary *authHeaderDict;
    
    if([self userIsLoggedIn]) 
    {
        authHeaderDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Your stuff", @"Title", 
                          [NSNumber numberWithInt:[[[self simpleOptions] objectForKey:@"Authenticated"] count]], @"RowCount", nil];
    }
    else 
    {
        authHeaderDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Login to see your stuff", @"Title", [NSNumber numberWithInt:2], @"RowCount", nil];
    }
    
    [menuArray insertObject:authHeaderDict atIndex:1];
    
    [searchHeaderDict release];
    [unauthHeaderDict release];
    [toolsHeaderDict release];
    [authHeaderDict release];
    
    return menuArray;
}

- (NSDictionary *)createMenuOptionsArray
{
    NSDictionary *dict = [[[NSDictionary alloc] initWithObjectsAndKeys:
                           [[[NSArray alloc] initWithObjects:@"Your Bookmarks", @"Your Tags", @"Tag Bundles", @"Subscriptions", @"Inbox", @"Network", nil] autorelease], @"Authenticated", 
                           [[[NSArray alloc] initWithObjects:@"Recent Bookmarks", @"Popular Bookmarks", @"Explore Tags", nil] autorelease], @"Unauthenticated", 
                           [[[NSArray alloc] initWithObjects:@"Look up a URL", @"Go to a user", nil] autorelease], @"Tools", 
                           nil] autorelease];
    
    return dict;
}

#pragma mark -
#pragma mark Authentication methods

- (BOOL)userIsLoggedIn
{
    return NO;
}

#pragma mark -
#pragma mark Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [self.sectionHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[[self.sectionHeaders objectAtIndex:section] objectForKey:@"RowCount"] integerValue];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return [[self.sectionHeaders objectAtIndex:section] objectForKey:@"Title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) 
    {
        case 0:
            return [self createSearchCellForTableView:tableView];
            
        case 1:
            if([self userIsLoggedIn]) {
                return [self createSimpleOptionCellForTableView:tableView atIndexPath:indexPath forOptionGroup:@"Authenticated"];
            }
            
            return [self createLoginCellForTableView:tableView atIndexPath:indexPath];
            
        case 2:
            return [self createSimpleOptionCellForTableView:tableView atIndexPath:indexPath forOptionGroup:@"Unauthenticated"];
            
        case 3:
            return [self createSimpleOptionCellForTableView:tableView atIndexPath:indexPath forOptionGroup:@"Tools"];
            
        default:
            break;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}

- (UITableViewCell *)createSearchCellForTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"SearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect frame = CGRectMake(50, 12, 230, 20);
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];    
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setPlaceholder:@"Type URLs, Tags or Keywords"];
    [textField setDelegate:self];
    [textField setAdjustsFontSizeToFitWidth:YES];
    [textField setReturnKeyType:UIReturnKeySearch];
    [textField setTag:1];
    
    [cell.contentView addSubview:textField];
    [textField release];
    
    return cell;
}

- (UITableViewCell *)createLoginCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    label.backgroundColor = [UIColor clearColor];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 180, 20)];
    textfield.delegate = self;
    textfield.placeholder = @"Required";
    
    if (indexPath.row == 0) 
    {
        label.text = @"Username";
        textfield.tag = 2;
    }
    else 
    {
        label.text = @"Password";
        textfield.tag = 3;
        textfield.secureTextEntry = YES;
    }
    
    [cell.contentView addSubview:label];
    [cell.contentView addSubview:textfield];
    
    [label release];
    [textfield release];
    
    return cell;
}

- (UITableViewCell *)createSimpleOptionCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath forOptionGroup:(NSString *)optionGroup
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[[self simpleOptions] objectForKey:optionGroup] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
	NSUInteger row = indexPath.row;
    
    // Hide the split view while we change the detail view
    [self.appDelegate.splitViewController viewWillDisappear:YES];
    
    // Remove the current detail view
	NSMutableArray *viewControllerArray = [[NSMutableArray alloc] initWithArray:[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] viewControllers]];
    
	[viewControllerArray removeLastObject];
    
    if(indexPath.section == 2) 
    {
        if (row == 0) 
        {
            RecentBookmarksViewController *controller = [[RecentBookmarksViewController alloc] init];
            [viewControllerArray addObject:controller];
            
            self.appDelegate.splitViewController.delegate = controller;
        }
        else if (row == 1) 
        {
            PopularBookmarksViewController *controller = [[PopularBookmarksViewController alloc] init];
            [viewControllerArray addObject:controller];
            
            self.appDelegate.splitViewController.delegate = controller;
        }
    }
    
    [[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] setViewControllers:viewControllerArray animated:NO];	
	
    // Show the split view again
	[self.appDelegate.splitViewController viewWillAppear:YES];
    
	[viewControllerArray release];
    
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    if (path.section == 0)
    {
        return nil;
    }
    else if (path.section == 1 && [self userIsLoggedIn] == NO) 
    {
        return nil;
    }
    
    return path;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [sectionHeaders release];
    [simpleOptions release];
    
    [super dealloc];
}

@end

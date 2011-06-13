//
//  Bookmark.m
//  Yummy
//
//  Created by Craig on 12/06/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import "Bookmark.h"


@implementation Bookmark

@synthesize url = _url;
@synthesize title = _title;
@synthesize tags = _tags;

- (NSString*)description 
{
	return [NSString stringWithFormat:@"%@", self.title];
}

- (void)dealloc
{
    [_url release];
    [_title release];
    [_tags release];
    
    [super dealloc];
}

@end

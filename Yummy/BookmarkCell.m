//
//  BookmarkCell.m
//  Yummy
//
//  Created by Craig on 14/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookmarkCell.h"


@implementation BookmarkCell

@synthesize titleLabel, tagsLabel;

- (void)dealloc
{
    [titleLabel release];
    [tagsLabel release];
    
    [super dealloc];
}
@end

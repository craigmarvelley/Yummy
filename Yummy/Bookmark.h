//
//  Bookmark.h
//  Yummy
//
//  Created by Craig on 12/06/2011.
//  Copyright 2011 Box UK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Bookmark : NSObject 
{
    
    NSURL *_url;
    NSString *_title;
    NSArray *_tags;
    
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *tags;

@end

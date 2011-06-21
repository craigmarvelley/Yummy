//
//  TagSelectorViewController.h
//  Yummy
//
//  Created by Craig on 21/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TagSelectorViewController : UITableViewController {
    NSArray *tags;
}

@property (nonatomic, retain) NSArray *tags;

@end

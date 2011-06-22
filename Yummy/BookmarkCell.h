//
//  BookmarkCell.h
//  Yummy
//
//  Created by Craig on 14/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BookmarkCell : UITableViewCell <UIPopoverControllerDelegate> {
    NSArray *tags;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *tagsLabel;
    IBOutlet UIButton *tagsButton;
    UIPopoverController *tagsPopover;
}

@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *tagsLabel;
@property (nonatomic, retain) IBOutlet UIButton *tagsButton;
@property (nonatomic, retain) UIPopoverController *tagsPopover;

- (IBAction)tagsTouched:(id)sender;

@end

//
//  BookmarkWebViewController.h
//  Yummy
//
//  Created by Craig on 15/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 


@interface BookmarkWebViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    NSURL *URL;
    UIActionSheet *popoverActionSheet;
    IBOutlet UIWebView *webView;
    IBOutlet UIBarItem *menuButton;
}

@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, retain) UIActionSheet *popoverActionSheet;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIBarItem *menuButton;

@end
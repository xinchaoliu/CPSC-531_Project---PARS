//
//  AccountViewController.h
//  PARS
//
//  Created by Xinchao Liu on 4/29/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARSDatabase.h"
#import "PARSUserData.h"
#import "PARSAppsTableViewController.h"

@interface AccountViewController : UITableViewController

@property (strong, nonatomic) NSString* userID;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) PARSUserData* user;
@property (strong, nonatomic) NSMutableArray* myAppList;
@property (strong, nonatomic) NSMutableArray* parsAppList;
@property (strong, nonatomic) NSMutableArray* friendsAppList;
@property (strong, nonatomic) NSMutableArray* appList;
@property (strong, nonatomic) NSString* appListNavBarTitle;
@property (weak, nonatomic) IBOutlet UITextView *debugTextView;

- (IBAction)signoutButtonPressed:(id)sender;

@end

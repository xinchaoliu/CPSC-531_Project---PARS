//
//  AccountViewController.h
//  PARS
//
//  Created by Xinchao Liu on 4/29/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARSUserData.h"

@interface AccountViewController : UITableViewController

@property (strong, nonatomic) NSString* userID;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) PARSUserData* user;

- (IBAction)signoutButtonPressed:(id)sender;

@end

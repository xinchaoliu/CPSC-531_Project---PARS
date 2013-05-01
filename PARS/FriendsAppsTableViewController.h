//
//  MyAppsTableViewController.h
//  PARS
//
//  Created by Xinchao Liu on 4/28/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCell.h"
#import "PARSDatabase.h"
#import "PARSUserData.h"
#import "AppDetailViewController.h"

@interface FriendsAppsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* appList;
@property (strong, nonatomic) PARSUserData* user;
@property (strong, nonatomic) PARSUserData* selectedApp;

- (IBAction)backButtonPressed:(id)sender;

@end

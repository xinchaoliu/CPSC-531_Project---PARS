//
//  LoginViewController.h
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARSDatabase.h"
#import "PARSUserData.h"

@interface LoginViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) NSArray* login;
@property (strong, nonatomic) NSString* userID;

- (IBAction)signinButtonPressed:(id)sender;

@end

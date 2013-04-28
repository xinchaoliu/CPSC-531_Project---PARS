//
//  LoginViewController.m
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize login;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer* tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideKeyboard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.login = nil;
}

- (void)hideKeyboard
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)signinButtonPressed:(id)sender {
    self.login =
        [[PARSDatabase db] selectUserWithEmail:self.emailTextField.text
                                   andPassword:self.passwordTextField.text];
    PARSUserData* user = [self.login objectAtIndex: 0];
    if (user.user_id != nil)
    {
        self.navBar.topItem.title =
            [NSString stringWithFormat:@"Welcome, %@",user.user_name];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
        self.navBar.topItem.title = @"Wrong Password";
}
@end

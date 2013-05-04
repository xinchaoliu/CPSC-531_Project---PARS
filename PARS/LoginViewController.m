//
//  LoginViewController.m
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//
extern NSString* debug;
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize login;
@synthesize user;

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
    self.user = [self.login objectAtIndex: 0];
    if (user.user_id != nil)
    {
        [self performSegueWithIdentifier:@"signIn" sender:self];
        self.emailTextField.text = nil;
        self.passwordTextField.text = nil;
        self.navBar.topItem.title = @"PARS Demo";
        debug = @"";
    }
    else
        self.navBar.topItem.title = @"Wrong Password";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AccountViewController* vc = segue.destinationViewController;
    vc.user = self.user;
}

@end

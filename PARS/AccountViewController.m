//
//  AccountViewController.m
//  PARS
//
//  Created by Xinchao Liu on 4/29/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "AccountViewController.h"
#import "MyAppsTableViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize user;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navBar.topItem.title =
    [NSString stringWithFormat:@"Welcome, %@",user.user_name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signoutButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MyAppsTableViewController* vc = segue.destinationViewController;
    vc.user = self.user;
}

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

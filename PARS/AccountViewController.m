//
//  AccountViewController.m
//  PARS
//
//  Created by Xinchao Liu on 4/29/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize user;
@synthesize myAppList;
@synthesize parsAppList;
@synthesize friendsAppList;
@synthesize appList;
@synthesize appListNavBarTitle;

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
    PARSDatabase* db = [[PARSDatabase alloc] init];
    myAppList = [db getMyAppListWithUserID:user.user_id];
    parsAppList = [db getPARSAppListWithUserID:user.user_id];
    friendsAppList = [db getFriendsAppListWithUserID:user.user_id];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signoutButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    switch (indexPath.section) {
        case 0:
        {
            appListNavBarTitle = @"My Apps";
            appList = myAppList;
            break;
        }
        case 1:
        {
            appListNavBarTitle = @"Our Recommendations";
            appList = parsAppList;
            break;
        }
        case 2:
        {
            appListNavBarTitle = @"Friends Like";
            appList = friendsAppList;
            break;
        }
        default:
            break;
    }
    [self performSegueWithIdentifier:@"appList" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PARSAppsTableViewController* vc = segue.destinationViewController;
    vc.navBarTitle = appListNavBarTitle;
    vc.appList = appList;
}

@end

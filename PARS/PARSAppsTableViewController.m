//
//  MyAppsTableViewController.m
//  PARS
//
//  Created by Xinchao Liu on 4/28/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "PARSAppsTableViewController.h"


@interface PARSAppsTableViewController ()

@end

@implementation PARSAppsTableViewController

@synthesize appList;
@synthesize user;
@synthesize selectedApp;
@synthesize navBarTitle;

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
    self.view.backgroundColor = [UIColor lightTextColor];    
    self.navBar.topItem.title = navBarTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [appList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AppCell";
    AppCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PARSUserData* myApps = [appList objectAtIndex:indexPath.row];
    cell.appIcon = [UIImage imageWithData:
                    [NSData dataWithContentsOfURL:
                     [NSURL URLWithString: myApps.app_icon_link]]];
    cell.appName = myApps.app_name;
    cell.appDeveloper = myApps.app_developer;
    cell.appPrice = myApps.app_price;
    cell.appCategory = myApps.app_category;
    
    return cell;
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedApp = [appList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"appDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AppDetailViewController* vc = segue.destinationViewController;
    vc.appDetail = self.selectedApp;
}

@end

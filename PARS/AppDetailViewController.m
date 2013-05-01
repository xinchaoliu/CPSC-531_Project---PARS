//
//  AppDetailViewController.m
//  PARS
//
//  Created by Xinchao Liu on 5/1/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "AppDetailViewController.h"

@interface AppDetailViewController ()

@end

@implementation AppDetailViewController

@synthesize appDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navBar.topItem.title = appDetail.app_name;
    self.detailTextView.text =
        [NSString stringWithFormat:@"App name: %@\nApp developer: %@\nApp Category: %@",appDetail.app_name, appDetail.app_developer, appDetail.app_category];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end

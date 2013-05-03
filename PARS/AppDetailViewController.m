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
    self.appNameLabel.text = appDetail.app_name;
    self.appDeveloperLabel.text = appDetail.app_developer;
    self.appCategoryLabel.text = appDetail.app_category;
    self.appPriceLabel.text = appDetail.app_price;
    self.detailIconImage.image =
        [UIImage imageWithData:
            [NSData dataWithContentsOfURL:
                [NSURL URLWithString: appDetail.app_icon_link]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapOnViewIniTunesLabel:(id)sender {
    NSLog(@"Tap Received");
    NSString* appLink =
    [NSString stringWithFormat:
     @"itms-apps://itunes.apple.com/app/id%@",appDetail.app_id];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appLink]];
}

- (IBAction)dislikeButtonPressed:(id)sender {
    self.dislikeButton.enabled = NO;
}

- (IBAction)iHaveItButtonPressed:(id)sender {
    self.iHaveItButton.enabled = NO;
}

- (IBAction)likeItButtonPressed:(id)sender {
    self.likeItButton.enabled = NO;
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end

//
//  AppDetailViewController.h
//  PARS
//
//  Created by Xinchao Liu on 5/1/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARSUserData.h"	

@interface AppDetailViewController : UIViewController

@property (strong, nonatomic) PARSUserData* appDetail;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *detailIconImage;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appDeveloperLabel;
@property (weak, nonatomic) IBOutlet UILabel *appCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *appPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
@property (weak, nonatomic) IBOutlet UIButton *iHaveItButton;
@property (weak, nonatomic) IBOutlet UIButton *likeItButton;


- (IBAction)tapOnViewIniTunesLabel:(id)sender;
- (IBAction)dislikeButtonPressed:(id)sender;
- (IBAction)iHaveItButtonPressed:(id)sender;
- (IBAction)likeItButtonPressed:(id)sender;


- (IBAction)backButtonPressed:(id)sender;

@end

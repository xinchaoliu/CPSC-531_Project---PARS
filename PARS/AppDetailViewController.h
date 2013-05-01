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
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

- (IBAction)backButtonPressed:(id)sender;

@end

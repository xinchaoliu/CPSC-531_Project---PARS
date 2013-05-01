//
//  AppCell.h
//  PARS
//
//  Created by Xinchao Liu on 4/28/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppCell : UITableViewCell

@property (copy, nonatomic) UIImage* appIcon;
@property (copy, nonatomic) NSString* appName;
@property (copy, nonatomic) NSString* appDeveloper;
@property (copy, nonatomic) NSString* appPrice;
@property (copy, nonatomic) NSString* appCategory;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageInCell;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *developerLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *priceLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabelInCell;

@end

//
//  AppCell.m
//  PARS
//
//  Created by Xinchao Liu on 4/28/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

@synthesize appName;
@synthesize appDeveloper;
@synthesize appPrice;
@synthesize appCategory;
@synthesize appIcon;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAppIcon:(UIImage*)theAppIcon
{
    if(![theAppIcon isEqual:appIcon]) {
        appIcon = [theAppIcon copy];
        self.iconImageInCell.image = appIcon;
    }
}

- (void)setAppName:(NSString*)theAppName
{
    if (![theAppName isEqualToString:appName]) {
        appName = [theAppName copy];
        self.appNameLabelInCell.text = appName;
    }
}

- (void)setAppDeveloper:(NSString *)theAppDeveloper
{
    if (![theAppDeveloper isEqualToString:appDeveloper]) {
        appDeveloper = [theAppDeveloper copy];
        self.developerLabelInCell.text =
            [NSString stringWithFormat:@"By %@", appDeveloper];
    }
}

- (void)setAppPrice:(NSString *)theAppPrice
{
    if (![theAppPrice isEqualToString:appPrice]) {
        appPrice = [theAppPrice copy];
        self.priceLabelInCell.text = appPrice;
    }
}

- (void)setAppCategory:(NSString *)theAppCategory
{
    if (![theAppCategory isEqualToString:appCategory]) {
        appCategory = [theAppCategory copy];
        self.categoryLabelInCell.text = appCategory;
    }
}

@end

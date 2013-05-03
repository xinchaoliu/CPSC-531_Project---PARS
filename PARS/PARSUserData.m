//
//  PARSUserData.m
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "PARSUserData.h"

@implementation PARSUserData

@synthesize user_id;
@synthesize user_name;
@synthesize app_id;
@synthesize app_name;
@synthesize app_developer;
@synthesize app_price;
@synthesize app_icon_link;
@synthesize app_category;
@synthesize likes_rate;
@synthesize user_id_s;
@synthesize similarity;

- (id) initWithUserID:(NSString*)theUserID
          andUserName:(NSString*)theUserName
{
    self = [super init];
    if (self) {
        user_id = theUserID;
        user_name = theUserName;
    }
    return self;
}

- (id) initWithAppID:(NSString*)theAppID
          andAppName:(NSString*)theAppName
     andAppDeveloper:(NSString*)theAppDeveloper
         andAppPrice:(NSString*)theAppPrice
      andAppIconLink:(NSString*)theAppIconLink
      andAppCategory:(NSString*)theAppCategory
        andLikesRate:(NSString*)theLikesRate
{
    self = [super init];
    if (self) {
        app_id = theAppID;
        app_name = theAppName;
        app_developer = theAppDeveloper;
        app_price = theAppPrice;
        app_icon_link = theAppIconLink;
        app_category = theAppCategory;
        likes_rate = theLikesRate;
    }
    return self;
}

- (id) initWithUserID:(NSString*)theUserID
        andSimilarity:(NSString*)theSimilarity
{
    self = [super init];
    if (self) {
        user_id_s = theUserID;
        similarity = theSimilarity;
    }
    return self;
}

@end

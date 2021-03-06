//
//  PARSUserData.h
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARSUserData : NSObject

@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) NSString* user_name;

@property (strong, nonatomic) NSString* app_id;
@property (strong, nonatomic) NSString* app_name;
@property (strong, nonatomic) NSString* app_developer;
@property (strong, nonatomic) NSString* app_price;
@property (strong, nonatomic) NSString* app_icon_link;
@property (strong, nonatomic) NSString* app_category;
@property (strong, nonatomic) NSString* likes_rate;

@property (strong, nonatomic) NSString* user_id_s;
@property (strong, nonatomic) NSString* similarity;

- (id) initWithUserID:(NSString*)theUserID
          andUserName:(NSString*)theUserName;

- (id) initWithAppID:(NSString*)theAppID
          andAppName:(NSString*)theAppName
     andAppDeveloper:(NSString*)theAppDeveloper
         andAppPrice:(NSString*)theAppPrice
      andAppIconLink:(NSString*)theAppIconLink
      andAppCategory:(NSString*)theAppCategory
        andLikesRate:(NSString*)theLikesRate;

- (id) initWithUserID:(NSString*)theUserID
        andSimilarity:(NSString*)theSimilarity;

@end

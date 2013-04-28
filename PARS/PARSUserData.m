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

- (id) initWithUserID:(NSString*)theUserID andUserName:(NSString*)theUserName
{
    self = [super init];
    if (self) {
        user_id = theUserID;
        user_name = theUserName;
    }
    return self;
}

@end

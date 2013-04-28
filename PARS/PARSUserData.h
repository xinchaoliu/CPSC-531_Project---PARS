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

- (id) initWithUserID:(NSString*)theUserID andUserName:(NSString*)theUserName;

@end

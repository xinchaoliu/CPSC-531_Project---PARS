//
//  PARSDatabase.h
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PARSUserData.h"

@interface PARSDatabase : NSObject
{
    sqlite3* _databaseConnection;
}

+ (PARSDatabase*) db;

- (NSArray*) selectUserWithEmail:(NSString*)theEmail
                     andPassword:(NSString*)thePassword;

@end

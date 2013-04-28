//
//  PARSDatabase.m
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//

#import "PARSDatabase.h"

@implementation PARSDatabase

static PARSDatabase* _databaseObj;

+ (PARSDatabase*) db
{
    if (_databaseObj == nil) {
        _databaseObj = [[PARSDatabase alloc] init];
    }
    return _databaseObj;
}

- (id) init
{
    self = [super init];
    if (self) {
        NSString* databasePath =
            [[NSBundle mainBundle] pathForResource:@"PARS" ofType:@"sqlite"];
        if (sqlite3_open([databasePath UTF8String], &_databaseConnection)
                != SQLITE_OK) {
            NSLog(@"Failed to open database.");
        } 
    }
    return self;
}

- (void) dealloc
{
    sqlite3_close(_databaseConnection);
}

- (NSMutableArray*) selectUserWithEmail:(NSString*)theEmail
                     andPassword:(NSString*)thePassword
{
    NSMutableArray* login = [[NSMutableArray alloc] init];
    NSString* query1 = @"SELECT * FROM user WHERE user_email = '";
    NSString* query2 = @"' and user_password = '";
    NSString* query = [NSString stringWithFormat:@"%@%@%@%@'",query1, theEmail,
                                                        query2, thePassword];
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* userID;
    NSString* userName;
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                           [query length], &statement, nil) == SQLITE_OK) {
        sqlite3_step(statement);
        text = sqlite3_column_text(statement, 0);
        if (text)
            userID = [NSString stringWithCString:(const char*)text
                                        encoding:NSUTF8StringEncoding];
        else
            userID = nil;
        text = sqlite3_column_text(statement, 1);
        if (text)
            userName = [NSString stringWithCString:(const char*)text
                                        encoding:NSUTF8StringEncoding];
        else
            userName = nil;
        PARSUserData* theUser = [[PARSUserData alloc] initWithUserID:userID
                                                         andUserName:userName];
        [login addObject: theUser];
    sqlite3_finalize(statement);
    }
    return login;
}

@end

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

- (NSMutableArray*) selectAppsWithUserID:(NSString*)theUserID
{
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query1 = @"SELECT * FROM app INNER JOIN has ON app.app_id = ";
    NSString* query2 = @"has.app_id WHERE has.user_id = '";
    NSString* query =
        [NSString stringWithFormat:@"%@%@%@';",query1, query2, theUserID];
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* appID;
    NSString* appName;
    NSString* appDeveloper;
    NSString* appDesc;
    NSString* appPrice;
    NSString* appIconLink;
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                           [query length], &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {            
            text = sqlite3_column_text(statement, 0);
            if (text)
                appID = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                appID = nil;
            text = sqlite3_column_text(statement, 1);
            if (text)
                appName = [NSString stringWithCString:(const char*)text
                                             encoding:NSUTF8StringEncoding];
            else
                appName = nil;
            text = sqlite3_column_text(statement, 2);
            if (text)
                appDesc = [NSString stringWithCString:(const char*)text
                                             encoding:NSUTF8StringEncoding];
            else
                appDesc = nil;
            text = sqlite3_column_text(statement, 3);
            if (text)
                appIconLink = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appIconLink = nil;
            text = sqlite3_column_text(statement, 4);
            if (text)
                appDeveloper = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appDeveloper = nil;
            text = sqlite3_column_text(statement, 5);
            if (text)
                appPrice = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appPrice = nil;
            PARSUserData* theApp =
                [[PARSUserData alloc] initWithAppID:appID
                                         andAppName:appName
                                    andAppDeveloper:appDeveloper
                                         andAppDesc:appDesc
                                        andAppPrice:appPrice
                                     andAppIconLink:appIconLink];
            [appList addObject: theApp];
        }
        sqlite3_finalize(statement);
    }
    return appList;
}

@end

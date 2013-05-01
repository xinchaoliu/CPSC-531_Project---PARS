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

- (NSMutableArray*) selectMyAppsWithUserID:(NSString*)theUserID
{
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query1 = @"SELECT app.*, IFNULL(SUM(likes.likes_rate),0) AS ";
    NSString* query2 = @"likes_rate_total FROM app LEFT OUTER JOIN likes ON ";
    NSString* query3 = @"likes.app_id = app.app_id WHERE app.app_id IN (SELECT";
    NSString* query4 = @" has.app_id FROM has WHERE has.user_id = '";
    NSString* query5 = @"') GROUP BY app_id ORDER BY likes_rate_total DESC";
    NSString* query =
        [NSString stringWithFormat:@"%@%@%@%@%@%@;",query1, query2, query3,
                                        query4, theUserID, query5];
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* appID;
    NSString* appName;
    NSString* appDeveloper;
    NSString* appPrice;
    NSString* appIconLink;
    NSString* appCategory;
    NSString* likesRate;
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
                appIconLink = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appIconLink = nil;
            text = sqlite3_column_text(statement, 3);
            if (text)
                appDeveloper = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appDeveloper = nil;
            text = sqlite3_column_text(statement, 4);
            if (text)
                appPrice = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appPrice = nil;
            text = sqlite3_column_text(statement, 5);
            if (text)
                appCategory = [NSString stringWithCString:(const char*)text
                                              encoding:NSUTF8StringEncoding];
            else
                appCategory = nil;
            text = sqlite3_column_text(statement, 6);
            if (text)
                likesRate = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                likesRate = nil;
            PARSUserData* theApp =
                [[PARSUserData alloc] initWithAppID:appID
                                         andAppName:appName
                                    andAppDeveloper:appDeveloper
                                        andAppPrice:appPrice
                                     andAppIconLink:appIconLink
                                     andAppCategory:appCategory
                                       andLikesRate:likesRate];
            [appList addObject: theApp];
        }
        sqlite3_finalize(statement);
    }
    return appList;
}

- (NSMutableArray*) getFriendsAppListWithUserID:(NSString*)theUserID
{
    // SELECT app.*, SUM(likes_rate) AS total_friends_likes_rate FROM likes INNER JOIN app ON app.app_id = likes.app_id WHERE likes.user_id IN (SELECT user_id_b FROM friend WHERE user_id_a = '6') AND likes.app_id NOT IN (SELECT app_id FROM has WHERE user_id = '6') GROUP BY app_id ORDER BY total_friends_likes_rate DESC
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query1 = @"SELECT app.*, IFNULL(SUM(likes.likes_rate),0) AS ";
    NSString* query2 = @"likes_rate_total FROM app LEFT OUTER JOIN likes ON ";
    NSString* query3 = @"likes.app_id = app.app_id WHERE app.app_id IN (SELECT";
    NSString* query4 = @" has.app_id FROM has WHERE has.user_id IN (SELECT ";
    NSString* query5 = @"user_id_b FROM friend WHERE user_id_a = '";
    NSString* query6 = @"')) GROUP BY app_id ORDER BY likes_rate_total DESC";
    NSString* query =
    [NSString stringWithFormat:@"%@%@%@%@%@%@%@",query1, query2, query3,
                                            query4, query5, theUserID, query6];
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* appID;
    NSString* appName;
    NSString* appDeveloper;
    NSString* appPrice;
    NSString* appIconLink;
    NSString* appCategory;
    NSString* likesRate;
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
                appIconLink = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appIconLink = nil;
            text = sqlite3_column_text(statement, 3);
            if (text)
                appDeveloper = [NSString stringWithCString:(const char*)text
                                                  encoding:NSUTF8StringEncoding];
            else
                appDeveloper = nil;
            text = sqlite3_column_text(statement, 4);
            if (text)
                appPrice = [NSString stringWithCString:(const char*)text
                                              encoding:NSUTF8StringEncoding];
            else
                appPrice = nil;
            text = sqlite3_column_text(statement, 5);
            if (text)
                appCategory = [NSString stringWithCString:(const char*)text
                                                 encoding:NSUTF8StringEncoding];
            else
                appCategory = nil;
            text = sqlite3_column_text(statement, 6);
            if (text)
                likesRate = [NSString stringWithCString:(const char*)text
                                               encoding:NSUTF8StringEncoding];
            else
                likesRate = nil;
            PARSUserData* theApp =
            [[PARSUserData alloc] initWithAppID:appID
                                     andAppName:appName
                                andAppDeveloper:appDeveloper
                                    andAppPrice:appPrice
                                 andAppIconLink:appIconLink
                                 andAppCategory:appCategory
                                   andLikesRate:likesRate];
            [appList addObject: theApp];
        }
        sqlite3_finalize(statement);
    }
    return appList;
}

@end

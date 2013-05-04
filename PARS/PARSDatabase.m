//
//  PARSDatabase.m
//  PARS
//
//  Created by Xinchao Liu on 4/27/13.
//  Copyright (c) 2013 Project. All rights reserved.
//
extern NSString* debug;
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

- (NSMutableArray*) getMyAppListWithUserID:(NSString*)theUserID
{
    // SELECT app.*, IFNULL(SUM(likes.likes_rate),0) AS total_all_likes_rate FROM app LEFT OUTER JOIN likes ON likes.app_id = app.app_id WHERE app.app_id IN (SELECT has.app_id FROM has WHERE has.user_id = '1') GROUP BY app_id ORDER BY likes_rate_total DESC
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query =
        [NSString stringWithFormat:@"SELECT app.*, IFNULL(SUM(likes.likes_rate),0) AS total_all_likes_rate FROM app LEFT OUTER JOIN likes ON likes.app_id = app.app_id WHERE app.app_id IN (SELECT has.app_id FROM has WHERE has.user_id = '%@') GROUP BY app_id ORDER BY total_all_likes_rate DESC", theUserID];
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
    // SELECT app.*, SUM(likes_rate) AS total_friends_likes_rate FROM likes INNER JOIN app ON app.app_id = likes.app_id WHERE likes.user_id IN (SELECT user_id_b FROM friend WHERE user_id_a = '6') AND likes.app_id NOT IN (SELECT app_id FROM has WHERE user_id = '6') GROUP BY app_id ORDER BY total_friends_likes_rate DESC LIMIT 20
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query =
    [NSString stringWithFormat:@"SELECT app.*, SUM(likes_rate) AS total_friends_likes_rate FROM likes INNER JOIN app ON app.app_id = likes.app_id WHERE likes.user_id IN (SELECT user_id_b FROM friend WHERE user_id_a = '%@') AND likes.app_id NOT IN (SELECT app_id FROM has WHERE user_id = '%@') GROUP BY app_id ORDER BY total_friends_likes_rate DESC LIMIT 20",theUserID, theUserID];
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

- (NSMutableArray*) getPARSAppListWithUserID:(NSString*)theUserID
{
    NSString* sUserId;
    NSArray* similarUserList = [self getSimilarUserWithUserID:theUserID];
    PARSUserData* first = [similarUserList objectAtIndex:0];
    PARSUserData* second = [similarUserList objectAtIndex:1];
    PARSUserData* third = [similarUserList objectAtIndex:2];
    sUserId = [NSString stringWithFormat:@"%@, %@, %@",first.user_id_s,second.user_id_s,third.user_id_s];
    NSLog(@"%@",sUserId);
    NSMutableArray* appList = [[NSMutableArray alloc] init];
    NSString* query =
    [NSString stringWithFormat:@"SELECT app.*, SUM(likes_rate) AS total_friends_likes_rate FROM likes INNER JOIN app ON app.app_id = likes.app_id WHERE likes.user_id IN (%@) AND likes.app_id NOT IN (SELECT app_id FROM has WHERE user_id = '%@') GROUP BY app_id ORDER BY total_friends_likes_rate DESC LIMIT 20",sUserId,theUserID];
    NSLog(@"%@",query);
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

- (NSMutableArray*) prepareSimilarUserWithUserID:(NSString*)theUserID
{
    // SELECT user_id,COUNT(user_id) AS 'similarity' FROM likes WHERE app_id IN (SELECT app_id FROM likes WHERE user_id= '1' AND likes_rate = '-1') AND user_id != '1' AND likes_rate = '-1' GROUP BY user_id UNION SELECT user_id,COUNT(user_id) AS 'similarity' FROM likes WHERE app_id IN (SELECT app_id FROM likes WHERE user_id= '1' AND likes_rate = '1') AND user_id != '1' AND likes_rate = '1' GROUP BY user_id ORDER BY similarity DESC
    
    NSMutableArray* userList = [[NSMutableArray alloc] init];
    NSString* query =
    [NSString stringWithFormat:@"SELECT user_id,COUNT(user_id) AS 'similarity' FROM likes WHERE app_id IN (SELECT app_id FROM likes WHERE user_id= '%@' AND likes_rate = '-1') AND user_id != '%@' AND likes_rate = '-1' GROUP BY user_id UNION SELECT user_id,COUNT(user_id) AS 'similarity' FROM likes WHERE app_id IN (SELECT app_id FROM likes WHERE user_id= '%@' AND likes_rate = '1') AND user_id != '%@' AND likes_rate = '1' GROUP BY user_id ORDER BY similarity DESC",theUserID,theUserID,theUserID,theUserID];
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* userID;
    NSString* similarity;
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                           [query length], &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            text = sqlite3_column_text(statement, 0);
            if (text)
                userID = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                userID = nil;
            text = sqlite3_column_text(statement, 1);
            if (text)
                similarity = [NSString stringWithCString:(const char*)text
                                             encoding:NSUTF8StringEncoding];
            else
                similarity = nil;
            debug = [NSString stringWithFormat:@"%@%@: %@\n",debug,userID,similarity];
            PARSUserData* theUser_s =
            [[PARSUserData alloc] initWithUserID:userID andSimilarity:similarity];
            [userList addObject: theUser_s];
        }
        sqlite3_finalize(statement);
    }
    return userList;
}

- (NSArray*) getSimilarUserWithUserID:(NSString *)theUserID
{
    NSArray* a = [self prepareSimilarUserWithUserID:theUserID];
    for (PARSUserData* obj in a) {
        NSString* query = [NSString stringWithFormat:@"SELECT COUNT(*) FROM likes WHERE user_id = '%@'",obj.user_id_s];
        sqlite3_stmt *statement;
        const unsigned char* text;
        NSString* fixedSimilarity;
        if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                               [query length], &statement, nil) == SQLITE_OK) {
            sqlite3_step(statement);
            text = sqlite3_column_text(statement, 0);
            if (text)
                fixedSimilarity = [NSString stringWithCString:(const char*)text
                                            encoding:NSUTF8StringEncoding];
            else
                fixedSimilarity = nil;
        }
        double s = sqrt([fixedSimilarity doubleValue]);
        query = [NSString stringWithFormat:@"SELECT COUNT(*) FROM likes WHERE user_id = '%@'",theUserID];
        NSString* userFixedSimilarity;
        if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                               [query length], &statement, nil) == SQLITE_OK) {
            sqlite3_step(statement);
            text = sqlite3_column_text(statement, 0);
            if (text)
                userFixedSimilarity = [NSString stringWithCString:(const char*)text
                                                     encoding:NSUTF8StringEncoding];
            else
                userFixedSimilarity = nil;
        }        
        s = s * sqrt([userFixedSimilarity doubleValue]);
        s = [obj.similarity doubleValue] / s;
        obj.similarity = [NSString stringWithFormat:@"%f",s];
    }
    NSArray* sortedArray;
    sortedArray = [a sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* first = [(PARSUserData*)obj1 similarity];
        NSString* second = [(PARSUserData*)obj2 similarity];
        return [second compare:first];
    }];
    for (PARSUserData* obj in sortedArray)
    {
        debug = [NSString stringWithFormat:@"%@%@: %@\n",debug,obj.user_id_s,obj.similarity];
        NSLog(@"user_id = %@, similarity score = %@", obj.user_id_s,obj.similarity);
    }
    return sortedArray;
}



@end

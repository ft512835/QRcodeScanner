//
//  DBManager.m
//  VSL
//
//  Created by Himanshu Jadav on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+(DBManager*)sharedDBManager {
    static DBManager* sharedDBManager = nil;
    if (!sharedDBManager) {
        sharedDBManager = [[DBManager alloc] init];
    }
    return sharedDBManager;
}

-(id)init {
    self = [super init];
    if (self) {
        [self createEditableCopyOfDatabase];
    }
    return self;
}

-(NSString*)getDBPath {
    return [NSString stringWithFormat:@"%@/Documents/CoffeeMe.sqlite",NSHomeDirectory()];
}

-(BOOL)createEditableCopyOfDatabase {
    NSString*toDBPath = [self getDBPath];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:toDBPath isDirectory:&isDir]) {
        return YES;
    }
    else {
        NSString*fromDBPath = [[NSBundle mainBundle] pathForResource:@"CoffeeMe" ofType:@"sqlite"];
        if (fromDBPath) {
            return [[NSFileManager defaultManager] copyItemAtPath:fromDBPath toPath:toDBPath error:nil];
        }
        return NO;
    }
}

- (NSMutableArray*) GetListBySQL:(NSString*)SQL
{
    const char *dbpath = [[self getDBPath] UTF8String];
    sqlite3_stmt    *statement;
    NSMutableArray*resultArr = nil;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {

        const char *query_stmt = [SQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            resultArr = [NSMutableArray array];
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int columnCount = sqlite3_column_count(statement);
                NSMutableDictionary*dataDict = [[NSMutableDictionary alloc] init];
                for (int i = 0; i < columnCount; i++)
                {
                    [dataDict setObject:[self getColumnString:(char *)sqlite3_column_text(statement, i)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(statement, i)]];
                }
                [resultArr addObject:dataDict];
                               dataDict = nil;
            } else
            {

            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    return resultArr;
}

-(NSString*)getColumnString:(char *)text
{
    if (text==NULL)
    {
        return @"";
    }
    return [NSString stringWithUTF8String:text];
}

@end

//
//  Database.h
//  Memory
//
//  Created by user on 16.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface Database : NSObject 
{
	NSString *dbPath;
}

@property(nonatomic,retain) NSString *dbPath;

+(NSString *) getDBPath:(NSString*)sqliteFilename;
-(void)copyDatabaseIfNeeded:(NSString *)sqliteFilename;
+(Database *)sharedObject;

+(NSString*)getObject:(NSObject *)object;

-(long long)insertToTable:(NSString *)tableName withValues:(NSDictionary *)dictionary;
-(BOOL)initializeWithSqlite:(NSString *)sqliteFilename;
-(NSMutableArray *)executeSelectQuery:(NSString *)query;
-(BOOL)deleteFromTableWithQuery:(NSString *)query;
-(NSString*)getObject:(NSObject *)object;
-(BOOL)updateTable:(NSString *)tableName values:(NSMutableDictionary *)dictionary forColumnCondition:(NSString *)column;
-(BOOL)dataWithUniqueIdFound:(NSString *)primaryKey inTable:(NSString *)tableName withPrimaryFieldName:(NSString *)fieldName;

+(BOOL)updateTable:(NSString *)tableName values:(NSMutableDictionary *)dictionary forColumnCondition:(NSString *)column;

-(NSString*)getColumnString:(char *)text;
-(BOOL)PerformStatement:(sqlite3_stmt *)statement withQuery:(NSString*)Query;

@end

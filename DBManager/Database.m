//
//  Database.m
//  Memory
//
//  Created by user on 16.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

static Database *sharedDatabase = nil;

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *updateStmt = nil;
static sqlite3_stmt *selectstmt = nil;

@implementation Database

@synthesize dbPath;

-(id)init {
    self = [super init];
    if (self) {
        [self copyDatabaseIfNeeded:@"CoffeeMe.sqlite"];
    }
    return self;
}

-(void)copyDatabaseIfNeeded:(NSString *)sqliteFilename {
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath1 = [[self class] getDBPath:sqliteFilename];
    
	BOOL success = [fileManager fileExistsAtPath:dbPath1];
	 
	if(!success) {
        NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"CoffeeMe" ofType:@"sqlite"];
        
        // Copy the database from the package to the users filesystem
        //[[NSFileManager defaultManager] copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
		//NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sqliteFilename];
        
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath1 error:&error];
        
		if (success) {
            NSLog(@"created Writable database file");
        }
		if (!success)
			NSLog(@"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

+(NSString *) getDBPath:(NSString*)sqliteFilename {
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:sqliteFilename];
}

+(Database *)sharedObject {
    @synchronized(self) {
        if (sharedDatabase == nil) {
            sharedDatabase = [[Database alloc] init];
        }
    }
    return sharedDatabase;
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}

-(BOOL)initializeWithSqlite:(NSString *)sqliteFilename {
	self.dbPath = [Database getDBPath:sqliteFilename];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
		return YES;
	else
		return NO;
}


-(void)dealloc {
    sqlite3_close(database);
	self.dbPath = nil;
	//[super dealloc];
}

-(NSString*)getObject:(NSObject *)object {
	NSString *value = nil;
	if ([object isKindOfClass:[NSString class]])
		value = [NSString stringWithFormat:@"%@",object];
	else if ([object isKindOfClass:[NSNumber class]]) {
		NSNumber *number = (NSNumber *)object;
		
		const char *str = [number objCType];
		
		if (strcmp(str, "i"))
			value = [NSString stringWithFormat:@"%d",[number intValue]];
		else if (strcmp(str, "f"))
			value = [NSString stringWithFormat:@"%f",[number floatValue]];
		else if (strcmp(str, "d"))
			value = [NSString stringWithFormat:@"%lf",[number floatValue]];
	}
	else if ([object isKindOfClass:[NSArray class]])
		value = nil;
	else if ([object isKindOfClass:[NSDictionary class]])
		value = nil;
	else {
		value = [NSString stringWithFormat:@"%@",object];
	}
	return value;
}

+(NSString*)getObject:(NSObject *)object {
	NSString *value = nil;
	if ([object isKindOfClass:[NSString class]])
		value = [NSString stringWithFormat:@"%@",object];
	else if ([object isKindOfClass:[NSNumber class]]) {
		NSNumber *number = (NSNumber *)object;
		
		const char *str = [number objCType];
		
		if (strcmp(str, "i"))
			value = [NSString stringWithFormat:@"%d",[number intValue]];
		else if (strcmp(str, "f"))
			value = [NSString stringWithFormat:@"%f",[number floatValue]];
		else if (strcmp(str, "d"))
			value = [NSString stringWithFormat:@"%lf",[number floatValue]];
	}
	else if ([object isKindOfClass:[NSArray class]])
		value = nil;
	else if ([object isKindOfClass:[NSDictionary class]])
		value = nil;
	else {
		value = [NSString stringWithFormat:@"%@",object];
	}
	return value;
}

-(long long)insertToTable:(NSString *)tableName withValues:(NSDictionary *)dictionary {
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
    
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (",tableName];
        
        NSArray *keyArray = [dictionary allKeys];
        for (int i = 0; i<[keyArray count]; i++) {
            NSString *key = [keyArray objectAtIndex:i];
            
            if (i!=([keyArray count] - 1))
                sql =[sql stringByAppendingFormat:@" %@,",key];
            else
                sql =[sql stringByAppendingFormat:@" %@)",key];

        }
        
        sql = [sql stringByAppendingFormat:@" Values("];
        
        for (int i = 0; i<[keyArray count]; i++) {
            NSString *key = [keyArray objectAtIndex:i];
            NSString *obj = [dictionary objectForKey:key];
            if (i!=([keyArray count] - 1))
                sql =[sql stringByAppendingFormat:@" '%@',",obj];
            else
                sql =[sql stringByAppendingFormat:@" '%@');",obj];
            
        }
        
        addStmt = nil;
        
        if(addStmt == nil) {
            const char *query = [sql UTF8String];
            if(sqlite3_prepare_v2(database, query, -1, &addStmt, NULL) != SQLITE_OK)
                NSLog(@"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        }
        
        if(SQLITE_DONE != sqlite3_step(addStmt))
        NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
        else
        {
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
            long long primKey = sqlite3_last_insert_rowid(database);

        //Reset the add statement.
            sqlite3_reset(addStmt);
            sqlite3_finalize(addStmt);
            sqlite3_close(database);
            return primKey;
        }
        sqlite3_finalize(addStmt);
        sqlite3_close(database);
        return 0;
    }
    return 0;
}

-(BOOL)dataWithUniqueIdFound:(NSString *)primaryKey inTable:(NSString *)tableName withPrimaryFieldName:(NSString *)fieldName {
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
        NSString *query = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",tableName,fieldName,primaryKey];
        const char *sql = [query UTF8String];
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            if(sqlite3_step(selectstmt) == SQLITE_DONE)  {
                sqlite3_finalize(selectstmt);
                sqlite3_close(database);
                return YES;
            }
            else {
                sqlite3_finalize(selectstmt);
                sqlite3_close(database);
                return NO;
            }

        }
        else {
            sqlite3_finalize(selectstmt);
            sqlite3_close(database);
            return NO;
        }
    }
    return NO;
}


-(NSMutableArray *)executeSelectQuery:(NSString *)query {
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
        const char *sql = [query UTF8String];
        
        
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            while(sqlite3_step(selectstmt) == SQLITE_ROW) 
            {
                NSUInteger columnCount = sqlite3_column_count(selectstmt);
                NSUInteger j=0;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                while (j<columnCount) {
                    NSString *key = [NSString stringWithUTF8String:(char*)sqlite3_column_name(selectstmt, j)];
                    NSString *value = nil;
                    
                    switch (sqlite3_column_type(selectstmt, j)) {
                        case SQLITE_TEXT:
                            value = [self getColumnString:(char *)sqlite3_column_text(selectstmt, j)];
                            break;
                        case SQLITE_FLOAT:
                            value = [NSString stringWithFormat:@"%f",sqlite3_column_double(selectstmt, j)];
                            break;
                        case SQLITE_INTEGER:
                            value = [NSString stringWithFormat:@"%i",sqlite3_column_int(selectstmt, j)];
                            break;
                        case SQLITE_BLOB:
                            value = [self getColumnString:(char *)sqlite3_column_blob(selectstmt, j)];
                            break;
                        default:
                            break;
                    }
                    if (value) {
                        [dict setObject:value forKey:key];
                    }
                    else {
                        [dict setObject:@"" forKey:key];
                    }

                    j++;
                }
                [array addObject:dict];
                //[dict release];
            }
            sqlite3_finalize(selectstmt);
            sqlite3_close(database);
           // return [array autorelease];
            return array;
        }
    }
    return nil;
}

-(NSString*)getColumnString:(char *)text
{
    
    if (text==NULL) {
        return @"";
    }
    return [NSString stringWithUTF8String:text];
}

-(BOOL)deleteFromTableWithQuery:(NSString *)query
{
    deleteStmt = nil;
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
        NSString *deleteQuery = [[NSString alloc] initWithString:query];
        
        if(deleteStmt == nil) {
            const char *sql = [deleteQuery UTF8String];
            if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
                NSLog(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
        }
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
        {
            NSLog(@"error %s", sqlite3_errmsg(database));
        //	NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
            sqlite3_finalize(deleteStmt);
            sqlite3_close(database);
            return NO;
        }
        else {
            sqlite3_reset(deleteStmt);
            sqlite3_finalize(deleteStmt);
            sqlite3_close(database);
            return YES;
        }
        sqlite3_finalize(deleteStmt);
        sqlite3_close(database);
    }
    
    
    
    return NO;
}
/*
-(BOOL)deleteTripDataForProfile:(NSString *)Profile
{
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
        NSString *deleteQuery = [NSString stringWithFormat:@"delete from %@ where tripId IN (SELECT tripId FROM %@ WHERE profileId=\"%@\")",TBLTRIPDETAIL,TBLTRIPMASTER,Profile];
        deleteStmt = nil;
        if ([self PerformStatement:deleteStmt withQuery:deleteQuery]) {
            NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@ WHERE profileId=\"%@\"",TBLTRIPMASTER,Profile];
            if ([self PerformStatement:deleteStmt withQuery:deleteQuery])
            {
                NSDate*date = [NSDate date];
                NSDateFormatter*dateformatter = [[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:DDMMYYYY];
                NSString*strDate = [dateformatter stringFromDate:date];
                SAFERELEASE(dateformatter);
                BOOL success = [self updateTable:TBLPROFILEMASTER values:[NSMutableDictionary dictionaryWithObjectsAndKeys:strDate,@"lastClearedDate",
                                                           Profile, @"profileId", nil] forColumnCondition:@"profileId"];
                sqlite3_finalize(deleteStmt);
                sqlite3_close(database);
                return success;
            }
            
        }
        else
        {
            return NO;
        }
        sqlite3_finalize(deleteStmt);
        sqlite3_close(database);
    }
    return NO;
}
-(BOOL)deleteProfile:(NSString *)Profile
{
    if ([self deleteTripDataForProfile:Profile])
    {
        return [self deleteFromTable:TBLPROFILEMASTER condition:[NSString stringWithFormat:@"profileId = \"%@\"",Profile]];
    }
    return NO;
}*/
-(BOOL)PerformStatement:(sqlite3_stmt *)statement withQuery:(NSString*)Query
{
    if(statement == nil) {
        const char *sql = [Query UTF8String];
        if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK)
            NSLog(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
    }
    
    if (SQLITE_DONE != sqlite3_step(statement))
    {
        NSLog(@"error %s", sqlite3_errmsg(database));
        //	NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        sqlite3_finalize(statement);
//        sqlite3_close(database);
        return NO;
    }
    else {
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
//        sqlite3_close(database);
        return YES;
    }
}
-(BOOL)updateTable:(NSString *)tableName values:(NSMutableDictionary *)dictionary forColumnCondition:(NSString *)column
{
    BOOL open = [self initializeWithSqlite:@"CoffeeMe.sqlite"];
    
    if (open) {
        updateStmt = nil;
        NSString *query = [NSString stringWithFormat:@"update %@ Set ",tableName];
        
        NSArray *allKeys = [dictionary allKeys];
        for (int i=0; i < [allKeys count]; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            NSString *value = [dictionary objectForKey:key];
            if (i==([allKeys count]-1))
                query = [query stringByAppendingFormat:@"%@ = '%@'",key,value]; 
            else
                query = [query stringByAppendingFormat:@"%@ = '%@',",key,value]; 
        }
        
        NSString *condition = [self getObject:[dictionary objectForKey:column]];
        
        query = [query stringByAppendingFormat:@" Where %@ = '%@'",column,condition];
        
        if(updateStmt == nil) {
            const char *sql = [query UTF8String];
            if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
                NSLog(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
        }
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
        {
            NSLog(@"Error while updating. '%s'", sqlite3_errmsg(database));
            sqlite3_finalize(updateStmt);
            sqlite3_close(database);
            return NO;
        }
        else {
            sqlite3_reset(updateStmt);
            sqlite3_finalize(updateStmt);
            sqlite3_close(database);
            return YES;
        }
    }
    return NO;
}

+(BOOL)updateTable:(NSString *)tableName values:(NSMutableDictionary *)dictionary forColumnCondition:(NSString *)column
{
    BOOL open;
    NSString *dbPath = [Database getDBPath:@"CoffeeMe.sqlite"];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
		open = YES;
	else
		open = NO;

    
    if (open) {
        updateStmt = nil;
        NSString *query = [NSString stringWithFormat:@"update %@ Set ",tableName];
        
        NSArray *allKeys = [dictionary allKeys];
        for (int i=0; i < [allKeys count]; i++) {
            NSString *key = [allKeys objectAtIndex:i];
            NSString *value = [dictionary objectForKey:key];
            if (i==([allKeys count]-1))
                query = [query stringByAppendingFormat:@"%@ = '%@'",key,value]; 
            else
                query = [query stringByAppendingFormat:@"%@ = '%@',",key,value]; 
        }
        
        NSString *condition = [Database getObject:[dictionary objectForKey:column]];
        
        query = [query stringByAppendingFormat:@" Where %@ = '%@'",column,condition];
        
        if(updateStmt == nil) {
            const char *sql = [query UTF8String];
            if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
                NSLog(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
        }
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
        {
            NSLog(@"Error while updating. '%s'", sqlite3_errmsg(database));
            sqlite3_finalize(updateStmt);
            sqlite3_close(database);
            return NO;
        }
        else {
            sqlite3_reset(updateStmt);
            sqlite3_finalize(updateStmt);
        }
       
    }
    return open;
}


@end

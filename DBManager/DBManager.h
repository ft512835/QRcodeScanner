//
//  DBManager.h
//  VSL
//
//  Created by Himanshu Jadav on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject {
    sqlite3 *database;
}

-(BOOL)createEditableCopyOfDatabase;
-(NSString*)getColumnString:(char *)text;

@end

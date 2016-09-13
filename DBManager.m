//
//  DBManager.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-30.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "DBManager.h"

@interface DBManager()
{
    sqlite3 *database;
    NSInteger	primaryKey;
}
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
-(void)copyDatabaseIntoDocumentsDirectory;

@end

@implementation DBManager

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename
{
    self = [super init];
    if (self) {
        // Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        // Keep the database filename.
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}
-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    NSLog(@"Db file path = %@",destinationPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

-(BOOL)isDataBaseOpen{
    
    BOOL isOpen = NO;
    NSString *path = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    NSLog(@"Db file path = %@",path);
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        isOpen = YES;
        Boolean isTableCreated =[self createTipTable];
    }
    else
    {
        isOpen = NO;
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
    return isOpen;
}
-(Boolean)createTipTable{
    static char *sql = "CREATE TABLE tipTable (tip_id INTEGER PRIMARY KEY AUTOINCREMENT, tip_amount REAL NOT NULL , tip_date DATE NOT NULL )";
    Boolean tableCreated = false;
    
    sqlite3_stmt *insert_statement;
    
    if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK){
        NSLog(@"Failed To create table Statement");
        NSLog(@"%@",insert_statement);
    }
    int success = sqlite3_step(insert_statement);
    if (success == SQLITE_ERROR){
        tableCreated = false;
    }else{
        tableCreated = true;
    }
    return tableCreated;
    
}


- (void)inserTip:(TipDataModel*)insertTipContent
{
    if ([self isDataBaseOpen] == YES) {
        sqlite3_stmt *insert_statement;
        static char *sql = "INSERT INTO tipTable(tip_amount,tip_date) VALUES (insertTipContent.tip_amount,insertTipContent.tip_date)";
        
        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK){
            NSLog(@"Failed To Prepare Statement");
            
        }
    //    sqlite3_bind_text(insert_statement, 1, [(float)insertTipContent.tip_amount UTF8String], -1, SQLITE_TRANSIENT);
      /*  sqlite3_bind_text(insert_statement, 2, [contactObj.number1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 3, [contactObj.number2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 4, [contactObj.imageName UTF8String], -1, SQLITE_TRANSIENT);
        */
        int success = sqlite3_step(insert_statement);
        if (success == SQLITE_ERROR)
        {
            NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
        }else{
            NSLog(@"Inserted Record");
        }
        
        sqlite3_finalize(insert_statement);
        sqlite3_close(database);
    }

}

- (void)deleteTip:(TipDataModel*)deleteTipContent
{
}

- (void)updateTip:(TipDataModel*)updateTipContent
{
}

- (NSMutableArray*)getAllTipContentByDate:(NSDate*)date
{
    return nil;
}

@end

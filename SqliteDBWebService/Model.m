//
//  Model.m
//  
//
//  Created by Pavankumar Arepu on 12/10/2015.
//
//

#import "Model.h"

@interface Model()
{
    sqlite3 *dataBase;
    sqlite3_stmt *dbStatement;
}

@end

@implementation Model

static Model *sharedModel = nil;
+(Model *)sharedModel
{
    @synchronized(self)
    {
        if (sharedModel == nil)
        {
            sharedModel =[[Model alloc] init]; // assignment not done here
        }
    }
    return sharedModel;
}


-(void)creatingDB
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *writableDBPath = [self getDocumentaryPath];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (success)
        success=[fileManager removeItemAtPath:writableDBPath error:&error];
    //return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]
                              stringByAppendingPathComponent:@"EmployeeDB.sqlite"];
    
    success = [fileManager copyItemAtPath:defaultDBPath
                                   toPath:writableDBPath
                                    error:&error];
}

-(NSString *)getDocumentaryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"EmployeeDB.sqlite"];
}

-(BOOL)validateLoinCredentials:(NSString*)userName andPassword:(NSString*)password
{
    BOOL success;
    NSString *sqliteDBFilePath = [self getDocumentaryPath];
    
    if (sqlite3_open([sqliteDBFilePath UTF8String], &dataBase) == SQLITE_OK)
    {
        NSString *loginQuery = [NSString stringWithFormat:@"SELECT * FROM Login where username=\"%@\" and password=\"%@\"",userName,password];
        
        if (sqlite3_prepare_v2(dataBase, [loginQuery UTF8String], -1, &dbStatement, NULL) ==  SQLITE_OK)
            {
                while(sqlite3_step(dbStatement) == SQLITE_ROW)
                {
                    success=YES;
                }
            }
    }
    sqlite3_finalize(dbStatement);
    sqlite3_close(dataBase);
    return success;
}

@end

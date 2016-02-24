//
//  LocalDatabase.m
//  demo20160215
//
//  Created by 金钟 on 16/2/15.
//  Copyright © 2016年 金钟. All rights reserved.
//

#import "LocalDatabase.h"




@interface LocalDatabase (){
    sqlite3 *db; //声明一个sqlite3数据库
}

@end

@implementation LocalDatabase
-(instancetype)init{
    self = [super init];
    if(self){
        //LocalDatabase *db = [[LocalDatabase alloc]init];
        [self openDB];
        [self createTable];
        
    }
    return self;
}

+ (LocalDatabase *)sharedManager {
    static LocalDatabase *sharedAccountManagerInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    
    return sharedAccountManagerInstance;
    
}

//+ (sqlite3 *)sharedManager {
//    static sqlite3 *db = nil;
//    
//    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
//        db = [[sqlite3 alloc] init];
//    });
//    
//    return db;
//    
//}

-(NSString *)databaseFileFullName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"myDatabase.sqlite3"];
    return path;
}

- (void)openDB{
    if (sqlite3_open([[self databaseFileFullName] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"数据库打开失败。");
    }
}

//执行SQL语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
//ID INTEGER PRIMARY KEY AUTOINCREASE,
-(void)createTable{
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS DOWNLOADINFO  (LESSON_ID varchar PRIMARY KEY ,  LESSON_NAME varchar , LESSON_URL varchar, LESSON_SIZE varchar, LESSON_DOWNLOADING varchar, FINISHED varchar)";
    [self execSql:sqlCreateTable];
}

-(BOOL)findDownloading{
    NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sqlFindDownload UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            return YES;
//            char *ID = (char *)sqlite3_column_text(statement, 0);
//            if(ID==nil){
//                return NO;
//            }else{
//                return YES;
//            }
        }
        sqlite3_finalize(statement);
    
    }else{
        sqlite3_finalize(statement);
        return NO;
    }
    //sqlite3_finalize(statement);
    return NO;

}




-(BOOL)findConfig:(NSString *)les_id{
    //NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    NSString *sql = [NSString stringWithFormat:@"select * from DOWNLOADINFO where LESSON_ID='%@'",les_id];

    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            return YES;
            //            char *ID = (char *)sqlite3_column_text(statement, 0);
            //            if(ID==nil){
            //                return NO;
            //            }else{
            //                return YES;
            //            }
        }else{
            return NO;
        }
        //sqlite3_finalize(statement);
        
    }else{
        sqlite3_finalize(statement);
        return NO;
    }
    //sqlite3_finalize(statement);
    return NO;
    
}



-(SCDownlodaMode *)checkDownloading:(NSString *)les_id{
    //NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    NSString *sql = [NSString stringWithFormat:@"select * from DOWNLOADINFO where LESSON_ID='%@'",les_id];
    
    //NSString *sql = @"SELECT * FROM DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            // [array addObject:mode];//对么？
        }
        
    }
    sqlite3_finalize(statement);
    return mode;
    
}
-(BOOL)isDownload:(NSString *)les_id{
    //NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    NSString *sql = [NSString stringWithFormat:@"select * from DOWNLOADINFO where LESSON_ID='%@'",les_id];
    
    //NSString *sql = @"SELECT * FROM DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            // [array addObject:mode];//对么？
        }
        
    }
    sqlite3_finalize(statement);
    if([mode.finished isEqualToString:@"YES"]){
        return YES;
    }else{
        return NO;
    }
    
}

-(BOOL)isDownloading:(NSString *)les_id{
    //NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    NSString *sql = [NSString stringWithFormat:@"select * from DOWNLOADINFO where LESSON_ID='%@'",les_id];
    
    //NSString *sql = @"SELECT * FROM DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            // [array addObject:mode];//对么？
        }
        
    }else{
        return NO;
    }
    sqlite3_finalize(statement);
    if([mode.les_downloading isEqualToString:@"YES"]){
        return YES;
    }else{
        return NO;
    }
    
    
}
-(BOOL)isDownloadingName:(NSString *)les_name{
    //NSString *sqlFindDownload=@"select LESSON_ID from DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    NSString *sql = [NSString stringWithFormat:@"select * from DOWNLOADINFO where LESSON_NAME='%@'",les_name];
    
    //NSString *sql = @"SELECT * FROM DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            // [array addObject:mode];//对么？
        }
        
    }
    sqlite3_finalize(statement);
    if([mode.les_downloading isEqualToString:@"YES"]){
        return YES;
    }else{
        return NO;
    }
    
    
}

- (SCDownlodaMode *)getdownloadingData{
    
    NSString *sql = @"SELECT * FROM DOWNLOADINFO where LESSON_DOWNLOADING='YES'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            // [array addObject:mode];//对么？
        }
        
    }
    sqlite3_finalize(statement);
    return mode;
}


-(BOOL)findToDownload{
    NSString *sqlToDownload=@"select * from DOWNLOADINFO where FINISHED= 'NO'";
        sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sqlToDownload UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            return YES;
        }
        sqlite3_finalize(statement);
        
    }else{
        return NO;
    }
    return NO;
}
//NSString *sql = [NSString stringWithFormat:@"update DOWNLOADINFO set LESSON_DOWNLOADING = ? where LESSON_ID = '%@'",les_id];
-(void)updateDownloading:(NSString *)les_id{
    [self openDB];
    NSString *string=@"YES";
    NSString *sql = [NSString stringWithFormat:@"update DOWNLOADINFO set LESSON_DOWNLOADING = ? where LESSON_ID = '%@'",les_id];
    char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        // 下面的数字1，2是指上面问号的顺序
        const char *subjectChar = [string UTF8String];
        
        sqlite3_bind_text(stmt, 1, subjectChar, -1, NULL);
        
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"erroe updating tabels %s",errorMsg);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    
    
}

- (BOOL)updateDBInfoValueWithKey:(const char*)key value:(const char*)value{
    int ret = 0;
    //[self openDB];
    const char* sql = "update DOWNLOADINFO set LESSON_DOWNLOADING = ? where LESSON_ID = ?;";
    sqlite3_stmt* stmt;//
    int result =sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    printf("%s\n",sqlite3_errmsg(db));
    if (result==SQLITE_OK) {//准备语句
        sqlite3_bind_text(stmt, 1, value, -1, NULL);
        sqlite3_bind_text(stmt, 2, key, -1, NULL);
    }else{
        return NO;
    }
    ret = sqlite3_step(stmt);
    printf("ret:%d\n",ret);
    //sqlite3_busy_handler(db);
    if (SQLITE_DONE ==ret ) {//执行查询
        sqlite3_finalize(stmt);
        sqlite3_close(db);
        return YES;
    }else{
        return NO;
    }
}

-(void)updateTable{
    NSString *sqlUpdateTable = @"update DOWNLOADINFO set LESSON_DOWNLOADING='YES' where LESSON_ID='0001'";
    [self execSql:sqlUpdateTable];
    
}

-(void)releaseDownloading:(NSString *)les_id{
    NSString *sql=[NSString stringWithFormat:@"update DOWNLOADINFO set LESSON_DOWNLOADING = 'NO' where LESSON_ID = '%@'",les_id];
//    sqlite3_stmt *statement;
//    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
//    sqlite3_finalize(statement);
    [self execSql:sql];
}
-(void)updateFinished:(NSString *)les_id{
    NSString *sql=[NSString stringWithFormat:@"update DOWNLOADINFO set FINISHED = 'YES' where LESSON_ID = '%@'",les_id];
//    sqlite3_stmt *statement;
//    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
//    sqlite3_finalize(statement);
    [self execSql:sql];
}
-(void)releaseFinished:(NSString *)les_id{
    NSString *sql=[NSString stringWithFormat:@"update DOWNLOADINFO set FINISHED = 'NO' where LESSON_ID = '%@'",les_id];
//    sqlite3_stmt *statement;
//    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
//    sqlite3_finalize(statement);
    [self execSql:sql];
}
-(void)deleteData:(NSString *)les_id{
    NSString *sql=[NSString stringWithFormat:@"delete from DOWNLOADINFO where LESSON_ID = '%@'",les_id];
    //sqlite3_stmt *statement;
    [self execSql:sql];
}
- (SCDownlodaMode *)getdownloadData{
    
    NSString *sql = @"SELECT * FROM DOWNLOADINFO where FINISHED= 'NO'";
    sqlite3_stmt *statement;
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *ID = (char *)sqlite3_column_text(statement, 0);
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
            // NSLog(@"info:%@",info);
            
            //            [[NSNotificationCenter
            //              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
           // [array addObject:mode];//对么？
        }

    }
    sqlite3_finalize(statement);
    return mode;
}


- (void)closeDB{
    sqlite3_close(db);
}

//插入数据方法
- (void)insertRecordIntoTableName:(NSString *)tableName
                       withField1:(NSString *)field1 field1Value:(NSString *)field1Value
                        andField2:(NSString *)field2 field2Value:(NSString *)field2Value
                        andField3:(NSString *)field3 field3Value:(NSString *)field3Value
                        andField4:(NSString *)field4 field4Value:(NSString *)field4Value
                        andField5:(NSString *)field5 field5Value:(NSString *)field5Value
                        andField6:(NSString *)field6 field6Value:(NSString *)field6Value{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@','%@','%@') VALUES (?, ?, ?, ?,?,?)",tableName, field1, field2, field3, field4,field5,field6];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 3, [field3Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 4, [field4Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 5, [field5Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 6, [field6Value UTF8String], -1,NULL);
    }
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSAssert(0, @"插入数据失败！");
        
    }
    sqlite3_finalize(statement);
    
}

//查询数据
- (NSMutableArray *)getAllData{
    
    NSString *sql = @"SELECT * FROM DOWNLOADINFO";
    sqlite3_stmt *statement;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            SCDownlodaMode *mode=[[SCDownlodaMode alloc]init];
            char *ID = (char *)sqlite3_column_text(statement, 0);
//            if(ID==nil)
//                break;
            mode.les_id = [[NSString alloc] initWithUTF8String:ID];
            
            char *name = (char *)sqlite3_column_text(statement, 1);
            mode.les_name = [[NSString alloc] initWithUTF8String:name];
            
            char *url = (char *)sqlite3_column_text(statement, 2);
            mode.les_url = [[NSString alloc] initWithUTF8String:url];
            
            char *size = (char *)sqlite3_column_text(statement, 3);
            mode.les_size = [[NSString alloc] initWithUTF8String:size];
            
            char *downloading = (char *)sqlite3_column_text(statement, 4);
            mode.les_downloading = [[NSString alloc] initWithUTF8String:downloading];
            
            char *finished = (char *)sqlite3_column_text(statement, 5);
            mode.finished = [[NSString alloc] initWithUTF8String:finished];
            //NSString *info = [[NSString alloc] initWithFormat:@"%@ - %@ - %@ -%@", IDStr, nameStr, ageStr, addressStr];
            
           // NSLog(@"info:%@",info);
            
//            [[NSNotificationCenter
//              defaultCenter] postNotificationName:@"myMessage" object:Nil userInfo:@{@"info":info}];
            [array addObject:mode];//对么？ 
        }
    }
    sqlite3_finalize(statement);

    return array;
}

@end

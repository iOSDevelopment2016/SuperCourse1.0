//
//  LocalDatabase.h
//  demo20160215
//
//  Created by 金钟 on 16/2/15.
//  Copyright © 2016年 金钟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SCDownlodaMode.h"


@interface LocalDatabase : NSObject

+ (LocalDatabase *)sharedManager ;
- (NSString *)databaseFileFullName;
- (void)openDB;
- (void)createTable;
- (void)closeDB;
- (void)insertRecordIntoTableName:(NSString *)tableName
                       withField1:(NSString *)field1 field1Value:(NSString *)field1Value
                        andField2:(NSString *)field2 field2Value:(NSString *)field2Value
                        andField3:(NSString *)field3 field3Value:(NSString *)field3Value
                        andField4:(NSString *)field4 field4Value:(NSString *)field4Value
                        andField5:(NSString *)field5 field5Value:(NSString *)field5Value
                        andField6:(NSString *)field6 field6Value:(NSString *)field6Value;
- (NSMutableArray *)getAllData;
-(BOOL)findDownloading;
-(BOOL)findToDownload;
- (SCDownlodaMode *)getdownloadData;
-(void)updateDownloading:(NSString *)name;
-(void)releaseDownloading:(NSString *)name;
-(void)updateFinished:(NSString *)name;
-(void)releaseFinished:(NSString *)name;
-(void)deleteData:(NSString *)name;
- (SCDownlodaMode *)getdownloadingData;
- (BOOL)updateDBInfoValueWithKey:(const char*)key value:(const char*)value;
-(void)updateTable;
-(BOOL)findConfig:(NSString *)les_id;
-(SCDownlodaMode *)checkDownloading:(NSString *)les_id;
-(BOOL)isDownload:(NSString *)les_id;
-(BOOL)isDownloading:(NSString *)les_id;
-(BOOL)isDownloadingName:(NSString *)les_name;
@end

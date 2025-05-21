//
//  MKAFDatabaseManager.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/6/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKAFDatabaseManager.h"

#import <FMDB/FMDB.h>

#import "MKMacroDefines.h"

@implementation MKAFDatabaseManager

+ (BOOL)initDataBase {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"LoRaWANBVDB")];
    if (![db open]) {
        return NO;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists LoRaWANBVTable (timestamp text,timezone text,deviceType text,macAddress text,rssi text,rawData text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        return NO;
    }
    return YES;
}

+ (void)insertDataList:(NSArray <NSDictionary *>*)dataList
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (!dataList) {
        [self operationInsertFailedBlock:failedBlock];
        return ;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"LoRaWANBVDB")];
    if (![db open]) {
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    NSString *sqlCreateTable = [NSString stringWithFormat:@"create table if not exists LoRaWANBVTable (timestamp text,timezone text,deviceType text,macAddress text,rssi text,rawData text)"];
    BOOL resCreate = [db executeUpdate:sqlCreateTable];
    if (!resCreate) {
        [db close];
        [self operationInsertFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"LoRaWANBVDB")] inDatabase:^(FMDatabase *db) {
        for (NSDictionary *dic in dataList) {
            [db executeUpdate:@"INSERT INTO LoRaWANBVTable (timestamp, timezone, deviceType, macAddress, rssi,rawData) VALUES (?,?,?,?,?,?)",SafeStr(dic[@"timestamp"]),SafeStr(dic[@"timezone"]),SafeStr(dic[@"deviceType"]),SafeStr(dic[@"macAddress"]),SafeStr(dic[@"rssi"]),SafeStr(dic[@"rawData"])];
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock();
            });
        }
        [db close];
    }];
}

+ (void)readDataListWithSucBlock:(void (^)(NSArray <NSDictionary *>*dataList))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"LoRaWANBVDB")];
    if (![db open]) {
        [self operationGetDataFailedBlock:failedBlock];
        return;
    }
    [[FMDatabaseQueue databaseQueueWithPath:kFilePath(@"LoRaWANBVDB")] inDatabase:^(FMDatabase *db) {
        NSMutableArray *tempDataList = [NSMutableArray array];
        FMResultSet * result = [db executeQuery:@"SELECT * FROM LoRaWANBVTable"];
        while ([result next]) {
            NSDictionary *resultDic = @{
                @"timestamp":[result stringForColumn:@"timestamp"],
                @"timezone":[result stringForColumn:@"timezone"],
                @"deviceType":[result stringForColumn:@"deviceType"],
                @"macAddress":[result stringForColumn:@"macAddress"],
                @"rssi":[result stringForColumn:@"rssi"],
                @"rawData":[result stringForColumn:@"rawData"],
            };
            [tempDataList addObject:resultDic];
        }
        if (sucBlock) {
            moko_dispatch_main_safe(^{
                sucBlock(tempDataList);
            });
        }
        [db close];
    }];
}

+ (BOOL)clearDataTable {
    FMDatabase* db = [FMDatabase databaseWithPath:kFilePath(@"LoRaWANBVDB")];
    if ([db open]) {
        BOOL success = [db executeUpdate:@"DELETE FROM LoRaWANBVTable"];
        [db close];
        return success;
    }
    return NO;
}

+ (void)operationFailedBlock:(void (^)(NSError *error))block msg:(NSString *)msg{
    if (block) {
        NSError *error = [[NSError alloc] initWithDomain:@"com.moko.databaseOperation"
                                                    code:-111111
                                                userInfo:@{@"errorInfo":msg}];
        moko_dispatch_main_safe(^{
            block(error);
        });
    }
}

+ (void)operationInsertFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"insert data error"];
}

+ (void)operationUpdateFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"update data error"];
}

+ (void)operationDeleteFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"fail to delete"];
}

+ (void)operationGetDataFailedBlock:(void (^)(NSError *error))block{
    [self operationFailedBlock:block msg:@"get data error"];
}

@end

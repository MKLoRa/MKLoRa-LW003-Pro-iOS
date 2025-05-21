//
//  MKAFTimingReportModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTimingReportModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFTimingReportModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFTimingReportModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readScanDuration]) {
            [self operationFailedBlockWithMsg:@"Read Scan Duration Error" block:failedBlock];
            return;
        }
        if (![self readScanTimePoint]) {
            [self operationFailedBlockWithMsg:@"Read Scan Time Point Error" block:failedBlock];
            return;
        }
        if (![self readReportTimePoint]) {
            [self operationFailedBlockWithMsg:@"Read Report Time Point Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configScanPointList:(NSArray <MKAFScanTimePointModel *>*)scanList
            reportPointList:(NSArray <MKAFScanTimePointModel *>*)reportList
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configScanDuration]) {
            [self operationFailedBlockWithMsg:@"Config Scan Duration Error" block:failedBlock];
            return;
        }
        if (![self configScanTimePoint:scanList]) {
            [self operationFailedBlockWithMsg:@"Config Scan Time Point Error" block:failedBlock];
            return;
        }
        if (![self configReportTimePoint:reportList]) {
            [self operationFailedBlockWithMsg:@"Config Report Time Point Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readScanDuration {
    __block BOOL success = NO;
    [MKAFInterface af_readTimingScanTimingReportDurationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.duration = returnData[@"result"][@"duration"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configScanDuration {
    __block BOOL success = NO;
    [MKAFInterface af_configTimingScanTimingReportDuration:[self.duration integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readScanTimePoint {
    __block BOOL success = NO;
    [MKAFInterface af_readTimingScanTimingReportScanTimePointWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *pointList = returnData[@"result"][@"pointList"];
        NSMutableArray *tempList= [NSMutableArray array];
        for (NSInteger i = 0; i < pointList.count; i ++) {
            NSDictionary *params = pointList[i];
            MKAFScanTimePointModel *pointModel = [[MKAFScanTimePointModel alloc] init];
            pointModel.hour = [params[@"hour"] integerValue];
            pointModel.minuteGear = [params[@"minuteGear"] integerValue];
            [tempList addObject:pointModel];
        }
        self.scanPointList = [NSArray arrayWithArray:tempList];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configScanTimePoint:(NSArray <MKAFScanTimePointModel *>*)pointList {
    __block BOOL success = NO;
    [MKAFInterface af_configTimingScanTimingReportScanTimePoint:pointList sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportTimePoint {
    __block BOOL success = NO;
    [MKAFInterface af_readTimingScanTimingReportReportTimePointWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *pointList = returnData[@"result"][@"pointList"];
        NSMutableArray *tempList= [NSMutableArray array];
        for (NSInteger i = 0; i < pointList.count; i ++) {
            NSDictionary *params = pointList[i];
            MKAFScanTimePointModel *pointModel = [[MKAFScanTimePointModel alloc] init];
            pointModel.hour = [params[@"hour"] integerValue];
            pointModel.minuteGear = [params[@"minuteGear"] integerValue];
            [tempList addObject:pointModel];
        }
        self.reportPointList = [NSArray arrayWithArray:tempList];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportTimePoint:(NSArray <MKAFScanTimePointModel *>*)pointList {
    __block BOOL success = NO;
    [MKAFInterface af_configTimingScanTimingReportReportTimePoint:pointList sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (BOOL)validParams {
    if (!ValidStr(self.duration) || [self.duration integerValue] < 3 || [self.duration integerValue] > 65535) {
        return NO;
    }
    return YES;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"timingModeParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("timingModeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

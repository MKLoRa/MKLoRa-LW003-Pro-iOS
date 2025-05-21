//
//  MKAFTimingImmediatelyModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTimingImmediatelyModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFTimingImmediatelyModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFTimingImmediatelyModel

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
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configData:(NSArray <MKAFScanTimePointModel *>*)pointList
          sucBlock:(void (^)(void))sucBlock
       failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configScanDuration]) {
            [self operationFailedBlockWithMsg:@"Config Scan Duration Error" block:failedBlock];
            return;
        }
        if (![self configScanTimePoint:pointList]) {
            [self operationFailedBlockWithMsg:@"Config Scan Time Point Error" block:failedBlock];
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
    [MKAFInterface af_readTimingScanImmediatelyReportDurationWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKAFInterface af_configTimingScanImmediatelyReportDuration:[self.duration integerValue] sucBlock:^{
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
    [MKAFInterface af_readTimingScanImmediatelyReportTimePointWithSucBlock:^(id  _Nonnull returnData) {
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
        self.pointList = [NSArray arrayWithArray:tempList];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configScanTimePoint:(NSArray <MKAFScanTimePointModel *>*)pointList {
    __block BOOL success = NO;
    [MKAFInterface af_configTimingScanImmediatelyReportTimePoint:pointList sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
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

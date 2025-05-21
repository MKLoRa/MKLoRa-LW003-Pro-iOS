//
//  MKAFPeriodicScanModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFPeriodicScanModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFPeriodicScanModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFPeriodicScanModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPeriodicScanPeriodicReport]) {
            [self operationFailedBlockWithMsg:@"Read Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configPeriodicScanPeriodicReport]) {
            [self operationFailedBlockWithMsg:@"Config Data Error" block:failedBlock];
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
- (BOOL)readPeriodicScanPeriodicReport {
    __block BOOL success = NO;
    [MKAFInterface af_readPeriodicScanPeriodicReportParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.scanInterval = returnData[@"result"][@"scanInterval"];
        self.scanDuration = returnData[@"result"][@"scanDuration"];
        self.reportInterval = returnData[@"result"][@"reportInterval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPeriodicScanPeriodicReport {
    __block BOOL success = NO;
    [MKAFInterface af_configPeriodicScanPeriodicReportDuration:[self.scanDuration integerValue] scanInterval:[self.scanInterval integerValue] reportInterval:[self.reportInterval integerValue] sucBlock:^{
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
    if (!ValidStr(self.scanInterval) || [self.scanInterval integerValue] < 3 || [self.scanInterval integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(self.scanDuration) || [self.scanDuration integerValue] < 3 || [self.scanDuration integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(self.reportInterval) || [self.reportInterval integerValue] < 3 || [self.reportInterval integerValue] > 65535) {
        return NO;
    }
    if ([self.scanInterval integerValue] < [self.scanInterval integerValue] || [self.reportInterval integerValue] < [self.scanInterval integerValue]) {
        return NO;
    }
    return YES;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"PeriodicScanPeriodicReport"
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
        _readQueue = dispatch_queue_create("PeriodicScanPeriodicReportQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

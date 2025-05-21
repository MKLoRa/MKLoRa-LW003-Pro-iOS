//
//  MKAFScanReportModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFScanReportModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFScanReportModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFScanReportModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readStrategiesSelection]) {
            [self operationFailedBlockWithMsg:@"Read Strategies Selection Error" block:failedBlock];
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
        if (![self configStrategiesSelection]) {
            [self operationFailedBlockWithMsg:@"Config Strategies Selection Error" block:failedBlock];
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
- (BOOL)readStrategiesSelection {
    __block BOOL success = NO;
    [MKAFInterface af_readScanReportStrategiesWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.strategy = [returnData[@"result"][@"strategy"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configStrategiesSelection {
    __block BOOL success = NO;
    [MKAFInterface af_configScanReportStrategy:self.strategy sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"ScanReportParams"
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
        _readQueue = dispatch_queue_create("ScanReportQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

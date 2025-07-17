//
//  MKAFBleGatewaySettingsModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFBleGatewaySettingsModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFBleGatewaySettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFBleGatewaySettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readDuplicateDataFilter]) {
            [self operationFailedBlockWithMsg:@"Read Duplicate Data Filter Error" block:failedBlock];
            return;
        }
        if (![self readReportDataMaxLength]) {
            [self operationFailedBlockWithMsg:@"Read Report Data Max Length Error" block:failedBlock];
            return;
        }
        if (![self readDataRetentionStrategy]) {
            [self operationFailedBlockWithMsg:@"Read Data Retention Strategy Error" block:failedBlock];
            return;
        }
        if (![self readAdvPacket]) {
            [self operationFailedBlockWithMsg:@"Read Advertising Packet Report Only Error" block:failedBlock];
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
        if (![self configDuplicateDataFilter]) {
            [self operationFailedBlockWithMsg:@"Config Duplicate Data Filter Error" block:failedBlock];
            return;
        }
        if (![self configReportDataMaxLength]) {
            [self operationFailedBlockWithMsg:@"Config Report Data Max Length Error" block:failedBlock];
            return;
        }
        if (![self configDataRetentionStrategy]) {
            [self operationFailedBlockWithMsg:@"Config Data Retention Strategy Error" block:failedBlock];
            return;
        }
        if (![self configAdvPacket]) {
            [self operationFailedBlockWithMsg:@"Config Advertising Packet Report Only Error" block:failedBlock];
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
- (BOOL)readDuplicateDataFilter {
    __block BOOL success = NO;
    [MKAFInterface af_readDuplicateDataFilterWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.filter = [returnData[@"result"][@"filter"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDuplicateDataFilter {
    __block BOOL success = NO;
    [MKAFInterface af_configDuplicateDataFilter:self.filter sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportDataMaxLength {
    __block BOOL success = NO;
    [MKAFInterface af_readReportDataMaxLengthWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dataLen = [returnData[@"result"][@"level"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportDataMaxLength {
    __block BOOL success = NO;
    [MKAFInterface af_configReportDataMaxLength:self.dataLen sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDataRetentionStrategy {
    __block BOOL success = NO;
    [MKAFInterface af_readDataRetentionStrategyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.strategy = [returnData[@"result"][@"strategy"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDataRetentionStrategy {
    __block BOOL success = NO;
    [MKAFInterface af_configDataRetentionStrategy:self.strategy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvPacket {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPUploadBroadcastWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advReport = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvPacket {
    __block BOOL success = NO;
    [MKAFInterface af_configBXPUploadBroadcastStatus:self.advReport sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"GatewaySettings"
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
        _readQueue = dispatch_queue_create("GatewayQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

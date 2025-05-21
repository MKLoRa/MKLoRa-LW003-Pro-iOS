//
//  MKAFFilterSettingModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFFilterSettingModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFFilterSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFFilterSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Read Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self readPHYMode]) {
            [self operationFailedBlockWithMsg:@"Read PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self readFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Filter Relationship Error" block:failedBlock];
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
        if (![self configFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Config Filter Rssi Error" block:failedBlock];
            return;
        }
        if (![self configPHYMode]) {
            [self operationFailedBlockWithMsg:@"Config PHY Mode Error" block:failedBlock];
            return;
        }
        if (![self configFilterRelationship]) {
            [self operationFailedBlockWithMsg:@"Config Filter Relationship Error" block:failedBlock];
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

- (BOOL)readFilterRssi {
    __block BOOL success = NO;
    [MKAFInterface af_readRssiFilterValueWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRssi {
    __block BOOL success = NO;
    [MKAFInterface af_configRssiFilterValue:self.rssi sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPHYMode {
    __block BOOL success = NO;
    [MKAFInterface af_readScanningPHYTypeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.phy = [returnData[@"result"][@"phyType"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPHYMode {
    __block BOOL success = NO;
    [MKAFInterface af_configScanningPHYType:self.phy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterRelationship {
    __block BOOL success = NO;
    [MKAFInterface af_readFilterRelationshipWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.relationship = [returnData[@"result"][@"relationship"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRelationship {
    __block BOOL success = NO;
    [MKAFInterface af_configFilterRelationship:self.relationship sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BleFixParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (self.rssi < -127 || self.rssi > 0) {
        return NO;
    }
    return YES;
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
        _readQueue = dispatch_queue_create("BluetoothFilterSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

//
//  MKAFTHSettingsModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/11/4.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTHSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFTHSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFTHSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFunctionStatus]) {
            [self operationFailedBlockWithMsg:@"Read Function Status Error" block:failedBlock];
            return;
        }
        if (![self readSampleRate]) {
            [self operationFailedBlockWithMsg:@"Read Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self readTemperature]) {
            [self operationFailedBlockWithMsg:@"Read Temperature Error" block:failedBlock];
            return;
        }
        if (![self readHumidity]) {
            [self operationFailedBlockWithMsg:@"Read Humidity Error" block:failedBlock];
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
        if (![self configFunctionStatus]) {
            [self operationFailedBlockWithMsg:@"Config Function Status Error" block:failedBlock];
            return;
        }
        if (![self configSampleRate]) {
            [self operationFailedBlockWithMsg:@"Config Sample Rate Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readFunctionStatus {
    __block BOOL success = NO;
    [MKAFInterface af_readTHFunctionStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.functionSwitch = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFunctionStatus {
    __block BOOL success = NO;
    [MKAFInterface af_configTHFunctionStatus:self.functionSwitch sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSampleRate {
    __block BOOL success = NO;
    [MKAFInterface af_readTHSampleRateWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleRate = returnData[@"result"][@"sampleRate"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSampleRate {
    __block BOOL success = NO;
    [MKAFInterface af_configTHSampleRate:[self.sampleRate integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTemperature {
    __block BOOL success = NO;
    [MKAFInterface af_readTemperatureWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.temperature = returnData[@"result"][@"temperature"];
        self.hasTemperature = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHumidity {
    __block BOOL success = NO;
    [MKAFInterface af_readHumidityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.humidity = returnData[@"result"][@"humidity"];
        self.hasHumidity = [returnData[@"result"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"THSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.sampleRate) || [self.sampleRate integerValue] < 1 || [self.sampleRate integerValue] > 10) {
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
        _readQueue = dispatch_queue_create("THSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

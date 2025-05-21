//
//  MKAFDeviceSettingModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFDeviceSettingModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface+MKAFConfig.h"
#import "MKAFInterface.h"

#import "MKAFConnectModel.h"

@interface MKAFDeviceSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFDeviceSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readTimeZone]) {
            [self operationFailedBlockWithMsg:@"Read Time Zone Error" block:failedBlock];
            return;
        }
        if (![self readLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Read Low Power Payload Error" block:failedBlock];
            return;
        }
        if (![self readLowPowerReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Low Power Report Interval Error" block:failedBlock];
            return;
        }
        if (![[MKAFConnectModel shared].deviceType isEqualToString:@"00"]) {
            if (![self readLowPowerPrompt]) {
                [self operationFailedBlockWithMsg:@"Read Low Power Prompt Error" block:failedBlock];
                return;
            }
        }
        if ([[MKAFConnectModel shared].deviceType isEqualToString:@"20"]) {
            //LW003-B PRO-C
            if (![self readChargingPriority]) {
                [self operationFailedBlockWithMsg:@"Read Charging Priority Error" block:failedBlock];
                return;
            }
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
        if (![self configTimeZone]) {
            [self operationFailedBlockWithMsg:@"Config Timezone Error" block:failedBlock];
            return;
        }
        if (![self configLowPowerPayload]) {
            [self operationFailedBlockWithMsg:@"Config Low-Power Payload Switch Error" block:failedBlock];
            return;
        }
        if (![self configLowPowerReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Low-Power Report Interval Error" block:failedBlock];
            return;
        }
        if (![[MKAFConnectModel shared].deviceType isEqualToString:@"00"]) {
            if (![self configLowPowerPrompt]) {
                [self operationFailedBlockWithMsg:@"Config Low-Power Prompt Error" block:failedBlock];
                return;
            }
        }
        if ([[MKAFConnectModel shared].deviceType isEqualToString:@"20"]) {
            //LW003-B PRO-C
            if (![self configChargingPriority]) {
                [self operationFailedBlockWithMsg:@"Config Charging Priority Error" block:failedBlock];
                return;
            }
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readTimeZone {
    __block BOOL success = NO;
    [MKAFInterface af_readTimeZoneWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeZone = [returnData[@"result"][@"timeZone"] integerValue] + 24;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTimeZone {
    __block BOOL success = NO;
    [MKAFInterface af_configTimeZone:(index - 24) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPayload {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPayload {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerPayloadStatus:self.lowPowerPayload sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPrompt {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerPromptWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.prompt = [returnData[@"result"][@"prompt"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPrompt {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerPrompt:self.prompt sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerReportInterval {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerPayloadIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerReportInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerReportInterval {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerPayloadInterval:[self.lowPowerReportInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readChargingPriority {
    __block BOOL success = NO;
    [MKAFInterface af_readChargingPriorityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.chargePriority = [returnData[@"result"][@"priority"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configChargingPriority {
    __block BOOL success = NO;
    [MKAFInterface af_configChargingPriority:self.chargePriority sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"DeviceSettingParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.lowPowerReportInterval) || [self.lowPowerReportInterval integerValue] < 1 || [self.lowPowerReportInterval integerValue] > 255) {
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
        _readQueue = dispatch_queue_create("DeviceSettingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

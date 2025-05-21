//
//  MKAFBXPButtonContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/29.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFBXPButtonContentModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFBXPButtonContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFBXPButtonContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBXPButtonContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPButton Content Error" block:failedBlock];
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
        if (![self configBXPButtonContent]) {
            [self operationFailedBlockWithMsg:@"Config BXPButton Content Error" block:failedBlock];
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
- (BOOL)readBXPButtonContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPButtonContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        self.triggerCount = [returnData[@"result"][@"triggerCount"] boolValue];
        self.deviceID = [returnData[@"result"][@"deviceID"] boolValue];
        self.firmwareType = [returnData[@"result"][@"firmwareType"] boolValue];
        self.deviceName = [returnData[@"result"][@"deviceName"] boolValue];
        self.temperature = [returnData[@"result"][@"temperature"] boolValue];
        self.axisData = [returnData[@"result"][@"axisData"] boolValue];
        self.txPower = [returnData[@"result"][@"txPower"] boolValue];
        self.rangingData = [returnData[@"result"][@"rangingData"] boolValue];
        self.frameType = [returnData[@"result"][@"frameType"] boolValue];
        self.battery = [returnData[@"result"][@"battery"] boolValue];
        self.statusFlag = [returnData[@"result"][@"statusFlag"] boolValue];
        self.fullScale = [returnData[@"result"][@"fullScale"] boolValue];
        self.motionThreshold = [returnData[@"result"][@"motionThreshold"] boolValue];
        self.axisData = [returnData[@"result"][@"axisData"] boolValue];
        self.advertising = [returnData[@"result"][@"advertising"] boolValue];
        self.response = [returnData[@"result"][@"response"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPButtonContent {
    __block BOOL success = NO;
    [MKAFInterface af_configBXPButtonContent:self sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"BXPButtonContent"
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
        _readQueue = dispatch_queue_create("BXPButtonContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

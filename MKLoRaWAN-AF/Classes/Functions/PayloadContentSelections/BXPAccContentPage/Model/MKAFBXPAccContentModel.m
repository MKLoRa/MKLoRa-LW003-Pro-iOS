//
//  MKAFBXPAccContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/29.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFBXPAccContentModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFBXPAccContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFBXPAccContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBXPACCContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPACC Content Error" block:failedBlock];
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
        if (![self configBXPACCContent]) {
            [self operationFailedBlockWithMsg:@"Config BXPACC Content Error" block:failedBlock];
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
- (BOOL)readBXPACCContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPACCContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        self.txPower = [returnData[@"result"][@"txPower"] boolValue];
        self.rangingData = [returnData[@"result"][@"rangingData"] boolValue];
        self.advInterval = [returnData[@"result"][@"advInterval"] boolValue];
        self.battery = [returnData[@"result"][@"battery"] boolValue];
        self.sampleRate = [returnData[@"result"][@"sampleRate"] boolValue];
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

- (BOOL)configBXPACCContent {
    __block BOOL success = NO;
    [MKAFInterface af_configBXPACCContent:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BXPACCContent"
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
        _readQueue = dispatch_queue_create("BXPACCContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

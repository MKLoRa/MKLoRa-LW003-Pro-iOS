//
//  MKAFTLMContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTLMContentModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFTLMContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFTLMContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readTLMContent]) {
            [self operationFailedBlockWithMsg:@"Read TLM Content Error" block:failedBlock];
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
        if (![self configTLMContent]) {
            [self operationFailedBlockWithMsg:@"Config TLM Content Error" block:failedBlock];
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
- (BOOL)readTLMContent {
    __block BOOL success = NO;
    [MKAFInterface af_readTLMContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        self.version = [returnData[@"result"][@"version"] boolValue];
        self.battery = [returnData[@"result"][@"battery"] boolValue];
        self.temperature = [returnData[@"result"][@"temperature"] boolValue];
        self.ADV_CNT = [returnData[@"result"][@"ADV_CNT"] boolValue];
        self.SEC_CNT = [returnData[@"result"][@"SEC_CNT"] boolValue];
        self.advertising = [returnData[@"result"][@"advertising"] boolValue];
        self.response = [returnData[@"result"][@"response"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTLMContent {
    __block BOOL success = NO;
    [MKAFInterface af_configTLMContent:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"TLMContent"
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
        _readQueue = dispatch_queue_create("TLMContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

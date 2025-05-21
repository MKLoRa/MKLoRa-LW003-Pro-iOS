//
//  MKAFURLContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFURLContentModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFURLContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFURLContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readURLContent]) {
            [self operationFailedBlockWithMsg:@"Read URL Content Error" block:failedBlock];
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
        if (![self configURLContent]) {
            [self operationFailedBlockWithMsg:@"Config URL Content Error" block:failedBlock];
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
- (BOOL)readURLContent {
    __block BOOL success = NO;
    [MKAFInterface af_readURLContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        self.url = [returnData[@"result"][@"url"] boolValue];
        self.measured = [returnData[@"result"][@"measured"] boolValue];
        self.advertising = [returnData[@"result"][@"advertising"] boolValue];
        self.response = [returnData[@"result"][@"response"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configURLContent {
    __block BOOL success = NO;
    [MKAFInterface af_configURLContent:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"URLContent"
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
        _readQueue = dispatch_queue_create("URLContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

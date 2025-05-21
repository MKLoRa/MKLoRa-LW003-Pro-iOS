//
//  MKAFBXPBeaconContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/29.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFBXPBeaconContentModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFBXPBeaconContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFBXPBeaconContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBXPBeaconContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPBeacon Content Error" block:failedBlock];
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
        if (![self configBXPBeaconContent]) {
            [self operationFailedBlockWithMsg:@"Config BXPBeacon Content Error" block:failedBlock];
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
- (BOOL)readBXPBeaconContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPBeaconContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        self.uuid = [returnData[@"result"][@"uuid"] boolValue];
        self.major = [returnData[@"result"][@"major"] boolValue];
        self.minor = [returnData[@"result"][@"minor"] boolValue];
        self.measured = [returnData[@"result"][@"measured"] boolValue];
        self.txPower = [returnData[@"result"][@"txPower"] boolValue];
        self.advInterval = [returnData[@"result"][@"advInterval"] boolValue];
        self.advertising = [returnData[@"result"][@"advertising"] boolValue];
        self.response = [returnData[@"result"][@"response"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPBeaconContent {
    __block BOOL success = NO;
    [MKAFInterface af_configBXPBeaconContent:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"BXPBeaconContent"
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
        _readQueue = dispatch_queue_create("BXPBeaconContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

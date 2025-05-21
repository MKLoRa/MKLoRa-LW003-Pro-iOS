//
//  MKAFTofContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/5/16.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKAFTofContentModel.h"

#import "MKMacroDefines.h"
#import "NSObject+MKModel.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFTofContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFTofContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBXPTofContent]) {
            [self operationFailedBlockWithMsg:@"Read MK-Tof Content Error" block:failedBlock];
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
        if (![self configBXPTofContent]) {
            [self operationFailedBlockWithMsg:@"Config MK-Tof Content Error" block:failedBlock];
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
- (BOOL)readBXPTofContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPTofContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        [self mk_modelSetWithJSON:returnData[@"result"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBXPTofContent {
    __block BOOL success = NO;
    [MKAFInterface af_configBXPTofContent:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MKTofContent"
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
        _readQueue = dispatch_queue_create("MKTofContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

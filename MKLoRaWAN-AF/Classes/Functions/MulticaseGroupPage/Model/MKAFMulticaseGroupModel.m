//
//  MKAFMulticaseGroupModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFMulticaseGroupModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@interface MKAFMulticaseGroupModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFMulticaseGroupModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readGroupStatus]) {
            [self operationFailedBlockWithMsg:@"Read Multicase Group Status Error" block:failedBlock];
            return;
        }
        if (![self readMcAddr]) {
            [self operationFailedBlockWithMsg:@"Read McAddr Error" block:failedBlock];
            return;
        }
        if (![self readMcAppSkey]) {
            [self operationFailedBlockWithMsg:@"Read McAppSkey Error" block:failedBlock];
            return;
        }
        if (![self readMcNwkSkey]) {
            [self operationFailedBlockWithMsg:@"Read McNwkSkey Error" block:failedBlock];
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
        if (![self configMcAddr]) {
            [self operationFailedBlockWithMsg:@"Config McAddr Error" block:failedBlock];
            return;
        }
        if (![self configMcAppSkey]) {
            [self operationFailedBlockWithMsg:@"Config McAppSkey Error" block:failedBlock];
            return;
        }
        if (![self configMcNwkSkey]) {
            [self operationFailedBlockWithMsg:@"Config McNwkSkey Error" block:failedBlock];
            return;
        }
        if (![self configGroupStatus]) {
            [self operationFailedBlockWithMsg:@"Config Multicase Group Status Error" block:failedBlock];
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
- (BOOL)readGroupStatus {
    __block BOOL success = NO;
    [MKAFInterface af_readMulticaseGroupStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configGroupStatus {
    __block BOOL success = NO;
    [MKAFInterface af_configMulticaseGroupStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMcAddr {
    __block BOOL success = NO;
    [MKAFInterface af_readMcAddrWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.mcAddr = returnData[@"result"][@"mcAddr"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMcAddr {
    __block BOOL success = NO;
    [MKAFInterface af_configMcADDR:self.mcAddr sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMcAppSkey {
    __block BOOL success = NO;
    [MKAFInterface af_readMcAppSkeyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.mcAppSkey = returnData[@"result"][@"appSkey"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMcAppSkey {
    __block BOOL success = NO;
    [MKAFInterface af_configMcAPPSKEY:self.mcAppSkey sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMcNwkSkey {
    __block BOOL success = NO;
    [MKAFInterface af_readMcNwkSkeyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.mcNwkSkey = returnData[@"result"][@"nwkSkey"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMcNwkSkey {
    __block BOOL success = NO;
    [MKAFInterface af_configMcNWKSKEY:self.mcNwkSkey sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"MulticaseGroupParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (self.isOn) {
        if (!ValidStr(self.mcAddr) || self.mcAddr.length != 8) {
            return NO;
        }
        if (!ValidStr(self.mcNwkSkey) || self.mcNwkSkey.length != 32) {
            return NO;
        }
        if (!ValidStr(self.mcAppSkey) || self.mcAppSkey.length != 32) {
            return NO;
        }
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
        _readQueue = dispatch_queue_create("MulticaseGroupQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

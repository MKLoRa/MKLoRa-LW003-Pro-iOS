//
//  MKAFSelftestModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFSelftestModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface+MKAFConfig.h"
#import "MKAFInterface.h"

@interface MKAFSelftestModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFSelftestModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPCBAStatus]) {
            [self operationFailedBlockWithMsg:@"Read PCBA Status Error" block:failedBlock];
            return;
        }
        if (![self readSelftestStatus]) {
            [self operationFailedBlockWithMsg:@"Read Self Test Status Error" block:failedBlock];
            return;
        }
        if (![self readNonChargeVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Non-Charge Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self readNonChargeSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Read Non-Charge Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self readNonChargeSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Read Non-Charge Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configNonChargeVoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Non-Charge Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self configNonChargeSampleInterval]) {
            [self operationFailedBlockWithMsg:@"Config Non-Charge Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self configNonChargeSampleTimes]) {
            [self operationFailedBlockWithMsg:@"Config Non-Charge Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)validParams {
    if (self.voltageThreshold < 0 || self.voltageThreshold > 20) {
        return NO;
    }
    if (!ValidStr(self.sampleInterval) || [self.sampleInterval integerValue] < 1 || [self.sampleInterval integerValue] > 14400) {
        return NO;
    }
    if (!ValidStr(self.sampleTimes) || [self.sampleTimes integerValue] < 1 || [self.sampleTimes integerValue] > 100) {
        return NO;
    }
    
    return YES;
}

#pragma mark - interface
- (BOOL)readPCBAStatus {
    __block BOOL success = NO;
    [MKAFInterface af_readPCBAStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pcbaStatus = returnData[@"result"][@"status"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSelftestStatus {
    __block BOOL success = NO;
    [MKAFInterface af_readSelftestStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSString *binary = [self binaryByhex:returnData[@"result"][@"status"]];
        self.flash = [binary substringWithRange:NSMakeRange(7, 1)];
        self.thData = [binary substringWithRange:NSMakeRange(6, 1)];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonChargeVoltageThreshold {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerNonChargeVoltageThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.voltageThreshold = [returnData[@"result"][@"threshold"] integerValue] - 44;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonChargeVoltageThreshold {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerNonChargeVoltageThreshold:(self.voltageThreshold + 44) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonChargeSampleInterval {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerNonChargeMinSampleIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonChargeSampleInterval {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerNonChargeMinSampleInterval:[self.sampleInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNonChargeSampleTimes {
    __block BOOL success = NO;
    [MKAFInterface af_readLowPowerNonChargeSampleTimesWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleTimes = returnData[@"result"][@"times"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNonChargeSampleTimes {
    __block BOOL success = NO;
    [MKAFInterface af_configLowPowerNonChargeSampleTimes:[self.sampleTimes integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)binaryByhex:(NSString *)hex {
    NSDictionary *hexDic = @{
                             @"0":@"0000",@"1":@"0001",@"2":@"0010",
                             @"3":@"0011",@"4":@"0100",@"5":@"0101",
                             @"6":@"0110",@"7":@"0111",@"8":@"1000",
                             @"9":@"1001",@"A":@"1010",@"a":@"1010",
                             @"B":@"1011",@"b":@"1011",@"C":@"1100",
                             @"c":@"1100",@"D":@"1101",@"d":@"1101",
                             @"E":@"1110",@"e":@"1110",@"F":@"1111",
                             @"f":@"1111",
                             };
    NSString *binaryString = @"";
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,
                        [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"selftest"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("selftestQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

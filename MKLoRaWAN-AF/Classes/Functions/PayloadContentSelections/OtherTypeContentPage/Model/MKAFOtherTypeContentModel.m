//
//  MKAFOtherTypeContentModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFOtherTypeContentModel.h"


#import "MKMacroDefines.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKAFInterface.h"
#import "MKAFInterface+MKAFConfig.h"

@implementation MKAFOtherBlockOptionModel

- (BOOL)validParams {
    if (!ValidStr(self.dataType)) {
        //新需求，DataType为空等同于00，
        self.dataType = @"00";
    }
    if (!ValidStr(self.dataType) || self.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:self.dataType]) {
        return NO;
    }
    
    if (self.minIndex < 1 || self.minIndex > 29 || self.maxIndex < 1 || self.maxIndex > 29) {
        return NO;
    }
    if (self.maxIndex < self.minIndex) {
        return NO;
    }
    return YES;
}

@end

@interface MKAFOtherTypeContentModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFOtherTypeContentModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readOtherContent]) {
            [self operationFailedBlockWithMsg:@"Read Other Content Error" block:failedBlock];
            return;
        }
        if (![self readOtherBlockOptions]) {
            [self operationFailedBlockWithMsg:@"Read Other Block Options Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configBlockOptionList:(NSArray <MKAFOtherBlockOptionModel *>*)list
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configOtherContent]) {
            [self operationFailedBlockWithMsg:@"Config Other Content Error" block:failedBlock];
            return;
        }
        if (![self configOtherBlockOptions:list]) {
            [self operationFailedBlockWithMsg:@"Config Other Block Options Error" block:failedBlock];
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
- (BOOL)readOtherContent {
    __block BOOL success = NO;
    [MKAFInterface af_readOtherTypeContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = [returnData[@"result"][@"macAddress"] boolValue];
        self.rssi = [returnData[@"result"][@"rssi"] boolValue];
        self.timestamp = [returnData[@"result"][@"timestamp"] boolValue];
        
        self.advertising = [returnData[@"result"][@"advertising"] boolValue];
        self.response = [returnData[@"result"][@"response"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOtherContent {
    __block BOOL success = NO;
    [MKAFInterface af_configOtherTypeContent:self sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOtherBlockOptions {
    __block BOOL success = NO;
    [MKAFInterface af_readOtherBlockOptionsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *list = returnData[@"result"][@"optionList"];
        for (NSInteger i = 0; i < list.count; i ++) {
            NSDictionary *dic = list[i];
            MKAFOtherBlockOptionModel *model = [[MKAFOtherBlockOptionModel alloc] init];
            model.dataType = ([dic[@"type"] isEqualToString:@"00"] ? @"" : dic[@"type"]);
            model.minIndex = [dic[@"start"] integerValue];
            model.maxIndex = [dic[@"end"] integerValue];
            [self.blockList addObject:model];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOtherBlockOptions:(NSArray <MKAFOtherBlockOptionModel *>*)optionsList {
    __block BOOL success = NO;
    [MKAFInterface af_configOtherBlockOptions:optionsList sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"OtherContentParams"
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
        _readQueue = dispatch_queue_create("OtherContentQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

- (NSMutableArray<MKAFOtherBlockOptionModel *> *)blockList {
    if (!_blockList) {
        _blockList = [NSMutableArray array];
    }
    return _blockList;
}

@end

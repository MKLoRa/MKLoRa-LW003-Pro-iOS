//
//  MKAFDeviceInfoModel.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKAFDeviceInfoModel.h"

#import "MKMacroDefines.h"

#import "MKAFInterface.h"

@interface MKAFDeviceInfoModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKAFDeviceInfoModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBatteryPower]) {
            [self operationFailedBlockWithMsg:@"Read battery power error" block:failedBlock];
            return ;
        }
        if (![self readMacAddress]) {
            [self operationFailedBlockWithMsg:@"Read mac address error" block:failedBlock];
            return ;
        }
        if (![self readDeviceModel]) {
            [self operationFailedBlockWithMsg:@"Read device model error" block:failedBlock];
            return ;
        }
        if (![self readSoftware]) {
            [self operationFailedBlockWithMsg:@"Read software error" block:failedBlock];
            return ;
        }
        if (![self readHardware]) {
            [self operationFailedBlockWithMsg:@"Read hardware error" block:failedBlock];
            return ;
        }
        if (![self readFirmware]) {
            [self operationFailedBlockWithMsg:@"Read firmware error" block:failedBlock];
            return ;
        }
        if (![self readManu]) {
            [self operationFailedBlockWithMsg:@"Read manu error" block:failedBlock];
            return ;
        }
        if (![self readBeaconContent]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Content Error" block:failedBlock];
            return;
        }
        
        if (![self readUIDContent]) {
            [self operationFailedBlockWithMsg:@"Read UID Content Error" block:failedBlock];
            return;
        }
        
        if (![self readURLContent]) {
            [self operationFailedBlockWithMsg:@"Read URL Content Error" block:failedBlock];
            return;
        }
        
        if (![self readTLMContent]) {
            [self operationFailedBlockWithMsg:@"Read TLM Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPBeaconContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPBeacon Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPDeviceInfoContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPDeviceInfo Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPACCContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPACC Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPTHContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPTH Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPButtonContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPButton Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPTagContent]) {
            [self operationFailedBlockWithMsg:@"Read BXPTag Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPTofContent]) {
            [self operationFailedBlockWithMsg:@"Read MK-Tof Content Error" block:failedBlock];
            return;
        }
        
        if (![self readBXPPirContent]) {
            [self operationFailedBlockWithMsg:@"Read MK-Pir Content Error" block:failedBlock];
            return;
        }
        
        if (![self readOtherContent]) {
            [self operationFailedBlockWithMsg:@"Read Other Content Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readBatteryPower {
    __block BOOL success = NO;
    [MKAFInterface af_readBatteryVoltageWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger battery = [returnData[@"result"][@"voltage"] integerValue];
        self.battery = [NSString stringWithFormat:@"%.3f",(battery * 0.001)];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMacAddress {
    __block BOOL success = NO;
    [MKAFInterface af_readMacAddressWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = returnData[@"result"][@"macAddress"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceModel {
    __block BOOL success = NO;
    [MKAFInterface af_readDeviceModelWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.productMode = returnData[@"result"][@"modeID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSoftware {
    __block BOOL success = NO;
    [MKAFInterface af_readSoftwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.software = returnData[@"result"][@"software"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFirmware {
    __block BOOL success = NO;
    [MKAFInterface af_readFirmwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.firmware = returnData[@"result"][@"firmware"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHardware {
    __block BOOL success = NO;
    [MKAFInterface af_readHardwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.hardware = returnData[@"result"][@"hardware"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readManu {
    __block BOOL success = NO;
    [MKAFInterface af_readManufacturerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.manu = returnData[@"result"][@"manufacturer"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBeaconContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBeaconContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.beaconContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUIDContent {
    __block BOOL success = NO;
    [MKAFInterface af_readUIDContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uidContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readURLContent {
    __block BOOL success = NO;
    [MKAFInterface af_readURLContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.urlContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTLMContent {
    __block BOOL success = NO;
    [MKAFInterface af_readTLMContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tlmContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPBeaconContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPBeaconContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpBeaconContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPDeviceInfoContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPDeviceInfoContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpDeviceInfoContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPACCContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPACCContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpAccContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPTHContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPTHContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpTHContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPButtonContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPButtonContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpBtnContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPTagContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPTagContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpTSContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPTofContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPTofContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpTofContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBXPPirContent {
    __block BOOL success = NO;
    [MKAFInterface af_readBXPPirContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bxpPirContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOtherContent {
    __block BOOL success = NO;
    [MKAFInterface af_readOtherTypeContentWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.otherContent = returnData[@"result"][@"content"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"deviceInformation"
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
        _readQueue = dispatch_queue_create("deviceInfoParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end

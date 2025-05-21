//
//  CBPeripheral+MKAFAdd.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKAFAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_seriesNumber;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *af_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *af_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *af_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *af_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *af_storageData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *af_log;

- (void)af_updateCharacterWithService:(CBService *)service;

- (void)af_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)af_connectSuccess;

- (void)af_setNil;

@end

NS_ASSUME_NONNULL_END

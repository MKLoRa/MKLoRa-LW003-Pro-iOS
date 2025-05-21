//
//  CBPeripheral+MKAFAdd.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKAFAdd.h"

#import <objc/runtime.h>

static const char *af_manufacturerKey = "af_manufacturerKey";
static const char *af_seriesNumberKey = "af_seriesNumberKey";
static const char *af_deviceModelKey = "af_deviceModelKey";
static const char *af_hardwareKey = "af_hardwareKey";
static const char *af_softwareKey = "af_softwareKey";
static const char *af_firmwareKey = "af_firmwareKey";

static const char *af_passwordKey = "af_passwordKey";
static const char *af_disconnectTypeKey = "af_disconnectTypeKey";
static const char *af_customKey = "af_customKey";
static const char *af_storageDataKey = "af_storageDataKey";
static const char *af_logKey = "af_logKey";

static const char *af_passwordNotifySuccessKey = "af_passwordNotifySuccessKey";
static const char *af_disconnectTypeNotifySuccessKey = "af_disconnectTypeNotifySuccessKey";
static const char *af_customNotifySuccessKey = "af_customNotifySuccessKey";

@implementation CBPeripheral (MKAFAdd)

- (void)af_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &af_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
                objc_setAssociatedObject(self, &af_seriesNumberKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &af_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &af_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &af_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &af_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &af_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &af_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &af_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &af_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &af_storageDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)af_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &af_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &af_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &af_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)af_connectSuccess {
    if (![objc_getAssociatedObject(self, &af_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &af_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &af_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.af_manufacturer || !self.af_deviceModel || !self.af_hardware || !self.af_software || !self.af_firmware) {
        return NO;
    }
    if (!self.af_password || !self.af_disconnectType || !self.af_custom || !self.af_log || !self.af_storageData) {
        return NO;
    }
    return YES;
}

- (void)af_setNil {
    objc_setAssociatedObject(self, &af_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_seriesNumberKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &af_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_storageDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &af_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &af_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)af_manufacturer {
    return objc_getAssociatedObject(self, &af_manufacturerKey);
}

- (CBCharacteristic *)af_seriesNumber {
    return objc_getAssociatedObject(self, &af_seriesNumberKey);
}

- (CBCharacteristic *)af_deviceModel {
    return objc_getAssociatedObject(self, &af_deviceModelKey);
}

- (CBCharacteristic *)af_hardware {
    return objc_getAssociatedObject(self, &af_hardwareKey);
}

- (CBCharacteristic *)af_software {
    return objc_getAssociatedObject(self, &af_softwareKey);
}

- (CBCharacteristic *)af_firmware {
    return objc_getAssociatedObject(self, &af_firmwareKey);
}

- (CBCharacteristic *)af_password {
    return objc_getAssociatedObject(self, &af_passwordKey);
}

- (CBCharacteristic *)af_disconnectType {
    return objc_getAssociatedObject(self, &af_disconnectTypeKey);
}

- (CBCharacteristic *)af_custom {
    return objc_getAssociatedObject(self, &af_customKey);
}

- (CBCharacteristic *)af_storageData {
    return objc_getAssociatedObject(self, &af_storageDataKey);
}

- (CBCharacteristic *)af_log {
    return objc_getAssociatedObject(self, &af_logKey);
}

@end

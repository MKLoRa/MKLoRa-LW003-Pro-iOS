//
//  MKAFPeripheral.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFPeripheral.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "CBPeripheral+MKAFAdd.h"

@interface MKAFPeripheral ()

@property (nonatomic, strong)CBPeripheral *peripheral;

@end

@implementation MKAFPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoverServices {
    NSArray *services = @[[CBUUID UUIDWithString:@"180A"],  //厂商信息
                          [CBUUID UUIDWithString:@"AA00"]]; //自定义
    [self.peripheral discoverServices:services];
}

- (void)discoverCharacteristics {
    for (CBService *service in self.peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
            [self.peripheral discoverCharacteristics:@[] forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
            [self.peripheral discoverCharacteristics:@[] forService:service];
        }
    }
}

- (void)updateCharacterWithService:(CBService *)service {
    [self.peripheral af_updateCharacterWithService:service];
}

- (void)updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    [self.peripheral af_updateCurrentNotifySuccess:characteristic];
}

- (BOOL)connectSuccess {
    return [self.peripheral af_connectSuccess];
}

- (void)setNil {
    [self.peripheral af_setNil];
}

@end

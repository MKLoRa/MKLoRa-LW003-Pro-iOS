//
//  MKAFScanPageModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKAFScanPageModel : NSObject

/**
 当前model所在的row
 */
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)NSInteger rssi;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

/// 设备类型 @"00":LW003-B PRO-A    @"10":LW003-B PRO-B @"20":LW003-B PRO-C
@property (nonatomic, copy)NSString *deviceType;

@property (nonatomic, copy)NSString *macAddress;

/// 是否是低电状态
@property (nonatomic, assign)BOOL lowPower;

/// 电池百分比
@property (nonatomic, copy)NSString *battery;

/// 电压，V
@property (nonatomic, copy)NSString *voltage;

/// 是否需要密码连接
@property (nonatomic, assign)BOOL needPassword;

/// 温度,C
@property (nonatomic, copy)NSString *temperature;

/// 湿度,%
@property (nonatomic, copy)NSString *humidity;

/// 是否可连接
@property (nonatomic, assign)BOOL connectable;

@property (nonatomic, strong)NSNumber *txPower;

/// cell上面显示的时间
@property (nonatomic, copy)NSString *scanTime;

/**
 上一次扫描到的时间
 */
@property (nonatomic, copy)NSString *lastScanDate;

@end

NS_ASSUME_NONNULL_END

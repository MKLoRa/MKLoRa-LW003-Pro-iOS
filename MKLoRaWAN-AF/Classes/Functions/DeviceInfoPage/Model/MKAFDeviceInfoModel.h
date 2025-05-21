//
//  MKAFDeviceInfoModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFDeviceInfoModel : NSObject

/**
 软件版本
 */
@property (nonatomic, copy)NSString *software;

/**
 固件版本
 */
@property (nonatomic, copy)NSString *firmware;

/**
 硬件版本
 */
@property (nonatomic, copy)NSString *hardware;

/// 电池电压
@property (nonatomic, copy)NSString *battery;

/**
 mac地址
 */
@property (nonatomic, copy)NSString *macAddress;

/**
 产品型号
 */
@property (nonatomic, copy)NSString *productMode;

/**
 厂商信息
 */
@property (nonatomic, copy)NSString *manu;


@property (nonatomic, strong)NSNumber *beaconContent;

@property (nonatomic, strong)NSNumber *uidContent;

@property (nonatomic, strong)NSNumber *urlContent;

@property (nonatomic, strong)NSNumber *tlmContent;

@property (nonatomic, strong)NSNumber *bxpBeaconContent;

@property (nonatomic, strong)NSNumber *bxpDeviceInfoContent;

@property (nonatomic, strong)NSNumber *bxpAccContent;

@property (nonatomic, strong)NSNumber *bxpTHContent;

@property (nonatomic, strong)NSNumber *bxpBtnContent;

@property (nonatomic, strong)NSNumber *bxpTSContent;

@property (nonatomic, strong)NSNumber *bxpTofContent;

@property (nonatomic, strong)NSNumber *bxpPirContent;

@property (nonatomic, strong)NSNumber *otherContent;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

//
//  MKAFPirContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/5/16.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFPirContentModel : NSObject<mk_af_bxpPirContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;


@property (nonatomic, assign)BOOL pirDelayResponse;

@property (nonatomic, assign)BOOL doorStatus;

@property (nonatomic, assign)BOOL sensorSensitivity;

@property (nonatomic, assign)BOOL sensorDetection;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

@property (nonatomic, assign)BOOL rssi1m;

@property (nonatomic, assign)BOOL deviceName;



@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

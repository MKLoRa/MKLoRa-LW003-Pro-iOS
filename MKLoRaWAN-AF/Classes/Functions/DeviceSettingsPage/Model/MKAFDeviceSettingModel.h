//
//  MKAFDeviceSettingModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFDeviceSettingModel : NSObject

@property (nonatomic, assign)NSInteger timeZone;

@property (nonatomic, assign)BOOL lowPowerPayload;

@property (nonatomic, copy)NSString *lowPowerReportInterval;

@property (nonatomic, assign)NSInteger prompt;

@property (nonatomic, assign)NSInteger chargePriority;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

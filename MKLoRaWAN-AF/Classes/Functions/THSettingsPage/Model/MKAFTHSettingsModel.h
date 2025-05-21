//
//  MKAFTHSettingsModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/11/4.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFTHSettingsModel : NSObject

@property (nonatomic, assign)BOOL functionSwitch;

@property (nonatomic, copy)NSString *sampleRate;

@property (nonatomic, assign)BOOL hasTemperature;

@property (nonatomic, copy)NSString *temperature;

@property (nonatomic, assign)BOOL hasHumidity;

@property (nonatomic, copy)NSString *humidity;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

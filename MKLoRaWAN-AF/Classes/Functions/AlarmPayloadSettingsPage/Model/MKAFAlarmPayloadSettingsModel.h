//
//  MKAFAlarmPayloadSettingsModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/5/16.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFAlarmPayloadSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

/// Duplicate Alarm Data Filter 0:No  1:MAC   2:MAC+Data Type 3:MAC+Raw Data
@property (nonatomic, assign)NSInteger filter;

@property (nonatomic, copy)NSString *period;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

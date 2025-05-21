//
//  MKAFBeaconContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFBeaconContentModel : NSObject<mk_af_beaconContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;



@property (nonatomic, assign)BOOL uuid;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

/// Measured RSSI@1M
@property (nonatomic, assign)BOOL measured;



@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

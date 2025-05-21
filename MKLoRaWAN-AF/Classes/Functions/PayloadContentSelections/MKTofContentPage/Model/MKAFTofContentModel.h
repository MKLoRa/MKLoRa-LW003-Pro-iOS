//
//  MKAFTofContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/5/16.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFTofContentModel : NSObject<mk_af_bxpTofContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;


@property (nonatomic, assign)BOOL mfg;

@property (nonatomic, assign)BOOL beacon;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL ranging;

@property (nonatomic, assign)BOOL user;

@property (nonatomic, assign)BOOL subType;

@property (nonatomic, assign)BOOL deviceName;


@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

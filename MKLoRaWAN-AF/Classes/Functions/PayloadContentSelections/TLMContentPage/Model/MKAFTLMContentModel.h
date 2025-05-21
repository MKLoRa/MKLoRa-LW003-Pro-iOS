//
//  MKAFTLMContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFTLMContentModel : NSObject<mk_af_tlmContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;



@property (nonatomic, assign)BOOL version;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL ADV_CNT;

@property (nonatomic, assign)BOOL SEC_CNT;



@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

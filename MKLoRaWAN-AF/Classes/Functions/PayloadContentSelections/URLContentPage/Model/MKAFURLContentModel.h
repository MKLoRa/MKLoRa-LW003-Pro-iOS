//
//  MKAFURLContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFURLContentModel : NSObject<mk_af_urlContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;



/// RSSI@0M
@property (nonatomic, assign)BOOL measured;

@property (nonatomic, assign)BOOL url;


@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

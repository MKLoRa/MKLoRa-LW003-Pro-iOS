//
//  MKAFMessageTypeModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFMessageTypeModel : NSObject

@property (nonatomic, assign)NSInteger deviceInfoPayload;

@property (nonatomic, assign)NSInteger deviceInfoMaxRetransmission;

@property (nonatomic, assign)NSInteger heartbeatPayload;

@property (nonatomic, assign)NSInteger heartbeatMaxRetransmission;

@property (nonatomic, assign)NSInteger lowPowerPayload;

@property (nonatomic, assign)NSInteger lowPowerMaxRetransmission;

@property (nonatomic, assign)NSInteger eventPayload;

@property (nonatomic, assign)NSInteger eventMaxRetransmission;

@property (nonatomic, assign)NSInteger beaconPayload;

@property (nonatomic, assign)NSInteger beaconMaxRetransmission;

@property (nonatomic, assign)NSInteger alarmPayload;

@property (nonatomic, assign)NSInteger alarmMaxRetransmission;

@property (nonatomic, assign)NSInteger gatewayPayload;

@property (nonatomic, assign)NSInteger gatewayMaxRetransmission;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

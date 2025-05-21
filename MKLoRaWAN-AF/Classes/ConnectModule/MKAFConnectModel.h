//
//  MKAFConnectModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKAFConnectModel : NSObject

+ (MKAFConnectModel *)shared;

/// 设备连接的时候是否需要密码
@property (nonatomic, assign, readonly)BOOL hasPassword;

/// 设备类型 @"00":LW003-B PRO-A    @"10":LW003-B PRO-B @"20":LW003-B PRO-C
@property (nonatomic, copy, readonly)NSString *deviceType;

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param deviceType @"00":LW003-B PRO-A    @"10":LW003-B PRO-B @"20":LW003-B PRO-C
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
           deviceType:(NSString *)deviceType
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

//
//  MKAFBleSettingsModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/6/11.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFBleSettingsModel : NSObject

@property (nonatomic, copy)NSString *advName;

@property (nonatomic, copy)NSString *advInterval;

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,     //2dBm
 8,       //3dBm
 9,       //4dBm
 10,      //5dBm
 11,     //6dBm
 12,     //7dBm
 13,     //8dBm
 
 */
@property (nonatomic, assign)NSInteger txPower;

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, assign)BOOL needPassword;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

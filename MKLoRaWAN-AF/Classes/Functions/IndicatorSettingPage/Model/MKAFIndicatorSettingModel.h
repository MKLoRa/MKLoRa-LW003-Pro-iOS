//
//  MKAFIndicatorSettingModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/11/5.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFIndicatorSettingModel : NSObject

@property (nonatomic, assign)BOOL lowPower;

@property (nonatomic, assign)BOOL charged;

@property (nonatomic, assign)BOOL broadcast;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

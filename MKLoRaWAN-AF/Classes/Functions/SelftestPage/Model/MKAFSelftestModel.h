//
//  MKAFSelftestModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFSelftestModel : NSObject

@property (nonatomic, copy)NSString *thData;

@property (nonatomic, copy)NSString *flash;

@property (nonatomic, copy)NSString *pcbaStatus;

/// 0-2.2v  20-3.2v
@property (nonatomic, assign)NSInteger voltageThreshold;

@property (nonatomic, copy)NSString *sampleInterval;

@property (nonatomic, copy)NSString *sampleTimes;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

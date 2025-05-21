//
//  MKAFOtherTypeContentModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFOtherBlockOptionModel : NSObject<mk_af_otherTypeBlockDataProtocol>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.1~29.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.minIndex~29. 
@property (nonatomic, assign)NSInteger maxIndex;

- (BOOL)validParams;

@end

@interface MKAFOtherTypeContentModel : NSObject<mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@property (nonatomic, strong)NSMutableArray <MKAFOtherBlockOptionModel *>*blockList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configBlockOptionList:(NSArray <MKAFOtherBlockOptionModel *>*)list
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

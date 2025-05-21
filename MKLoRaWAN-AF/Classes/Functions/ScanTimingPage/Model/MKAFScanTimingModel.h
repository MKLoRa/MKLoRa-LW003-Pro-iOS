//
//  MKAFScanTimingModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFScanTimePointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFScanTimingModel : NSObject

@property (nonatomic, strong)NSArray <MKAFScanTimePointModel *>*pointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configData:(NSArray <MKAFScanTimePointModel *>*)pointList
          sucBlock:(void (^)(void))sucBlock
       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

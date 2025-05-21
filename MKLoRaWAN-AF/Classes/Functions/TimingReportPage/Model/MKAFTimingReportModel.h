//
//  MKAFTimingReportModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFScanTimePointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFTimingReportModel : NSObject

@property (nonatomic, copy)NSString *duration;

@property (nonatomic, strong)NSArray <MKAFScanTimePointModel *>*scanPointList;

@property (nonatomic, strong)NSArray <MKAFScanTimePointModel *>*reportPointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configScanPointList:(NSArray <MKAFScanTimePointModel *>*)scanList
            reportPointList:(NSArray <MKAFScanTimePointModel *>*)reportList
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

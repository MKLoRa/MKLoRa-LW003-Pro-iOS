//
//  MKAFScanReportModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFScanReportModel : NSObject

/*
 0:No Scan & No report
 1:Timing scan & Immediately report
 2:Periodic scan & Immediately report
 3:Scan always on & Periodic report
 4:Periodic scan & Periodic report
 5:Scan always on & Timing report
 6:Timing scan & Timing report
 7:Periodic scan & Timing report
 */
@property (nonatomic, assign)NSInteger strategy;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

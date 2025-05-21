//
//  MKAFScanTimePointModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFScanTimePointModel : NSObject<mk_af_scanTimePointProtocol>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:10   2:20   3:30    4:40   5:50
@property (nonatomic, assign)NSInteger minuteGear;

@end

NS_ASSUME_NONNULL_END

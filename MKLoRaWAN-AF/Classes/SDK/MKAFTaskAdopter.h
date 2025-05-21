//
//  MKAFTaskAdopter.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const mk_af_totalNumKey;
extern NSString *const mk_af_totalIndexKey;
extern NSString *const mk_af_contentKey;

@class CBCharacteristic;
@interface MKAFTaskAdopter : NSObject

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic;

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic;

@end

NS_ASSUME_NONNULL_END

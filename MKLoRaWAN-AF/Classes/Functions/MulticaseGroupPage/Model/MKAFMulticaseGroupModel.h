//
//  MKAFMulticaseGroupModel.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFMulticaseGroupModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *mcAddr;

@property (nonatomic, copy)NSString *mcAppSkey;

@property (nonatomic, copy)NSString *mcNwkSkey;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

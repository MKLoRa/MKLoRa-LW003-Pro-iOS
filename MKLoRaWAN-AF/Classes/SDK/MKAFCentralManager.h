//
//  MKAFCentralManager.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKAFOperationID.h"
#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

//Notification of device connection status changes.
extern NSString *const mk_af_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_af_centralManagerStateChangedNotification;

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. The device has no data communication for three consecutive minutes, it returns 0x02, and the shutdown protocol is sent to make the device shut down and return 0x03.Reset the device, return 0x04.After successful password change, it returns 0x05.
 */
extern NSString *const mk_af_deviceDisconnectTypeNotification;

@class CBCentralManager,CBPeripheral;
@class MKAFOperation;

@interface MKAFCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_af_centralManagerScanDelegate>delegate;

@property (nonatomic, weak)id <mk_af_storageDataDelegate>dataDelegate;

@property (nonatomic, weak)id <mk_af_centralManagerLogDelegate>logDelegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_af_centralConnectStatus connectStatus;

+ (MKAFCentralManager *)shared;

/// Destroy the MKAFCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKAFCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_af_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Connect device function.
/// @param peripheral peripheral
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_af_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_af_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

- (void)addOperation:(MKAFOperation *)operation;

/**
 Whether to monitor device storage data.

 @param notify BOOL
 @return result
 */
- (BOOL)notifyStorageData:(BOOL)notify;

/// Whether to open log data monitoring.
/// @param notify notify
- (BOOL)notifyLogData:(BOOL)notify;

@end

NS_ASSUME_NONNULL_END

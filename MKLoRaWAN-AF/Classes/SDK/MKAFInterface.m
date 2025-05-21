//
//  MKAFInterface.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKAFCentralManager.h"
#import "MKAFOperationID.h"
#import "MKAFOperation.h"
#import "CBPeripheral+MKAFAdd.h"
#import "MKAFSDKDataAdopter.h"

#define centralManager [MKAFCentralManager shared]
#define peripheral ([MKAFCentralManager shared].peripheral)

@implementation MKAFInterface

#pragma mark *********************Device Service Information*****************

+ (void)af_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_af_taskReadDeviceModelOperation
                           characteristic:peripheral.af_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)af_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_af_taskReadFirmwareOperation
                           characteristic:peripheral.af_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)af_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_af_taskReadHardwareOperation
                           characteristic:peripheral.af_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)af_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_af_taskReadSoftwareOperation
                           characteristic:peripheral.af_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)af_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_af_taskReadManufacturerOperation
                           characteristic:peripheral.af_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark *************************System***********************

+ (void)af_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadMacAddressOperation
                     cmdFlag:@"0015"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerStatusOperation
                     cmdFlag:@"0016"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimeZoneOperation
                     cmdFlag:@"0021"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"0022"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadIndicatorSettingsOperation
                     cmdFlag:@"0023"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTurnOffDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTurnOffDeviceByButtonStatusOperation
                     cmdFlag:@"0025"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readShutDownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadShutDownPayloadStatusOperation
                     cmdFlag:@"0026"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readContinuityTransferFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadContinuityTransferFunctionStatusOperation
                     cmdFlag:@"002a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBatteryVoltageOperation
                     cmdFlag:@"0040"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPCBAStatusOperation
                     cmdFlag:@"0041"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadSelftestStatusOperation
                     cmdFlag:@"0042"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTemperatureWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTemperatureOperation
                     cmdFlag:@"0043"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readHumidityWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadHumidityOperation
                     cmdFlag:@"0045"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readSolarBoardChargingCurrentWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadSolarBoardChargingCurrentOperation
                     cmdFlag:@"0046"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** Battery ************************************************

+ (void)af_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBatteryInformationOperation
                     cmdFlag:@"0101"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLastCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLastCycleBatteryInformationOperation
                     cmdFlag:@"0102"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAllCycleBatteryInformationOperation
                     cmdFlag:@"0103"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerPromptOperation
                     cmdFlag:@"0104"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"0106"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerPayloadIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerPayloadIntervalOperation
                     cmdFlag:@"0107"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAutoPowerOnAfterChargingWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAutoPowerOnAfterChargingOperation
                     cmdFlag:@"0108"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerNonChargeVoltageThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerNonChargeVoltageThresholdOperation
                     cmdFlag:@"010a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerNonChargeMinSampleIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerNonChargeMinSampleIntervalOperation
                     cmdFlag:@"010b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerNonChargeSampleTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerNonChargeSampleTimesOperation
                     cmdFlag:@"010c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readChargingPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadChargingPriorityOperation
                     cmdFlag:@"010d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Ble Params***********************
+ (void)af_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"0200"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPasswordOperation
                     cmdFlag:@"0201"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"0202"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAdvIntervalOperation
                     cmdFlag:@"0204"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTxPowerOperation
                     cmdFlag:@"0205"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadDeviceNameOperation
                     cmdFlag:@"0206"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Scan Fliter***********************

+ (void)af_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadScanningPHYTypeOperation
                     cmdFlag:@"0400"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadRssiFilterValueOperation
                     cmdFlag:@"0401"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterRelationshipOperation
                     cmdFlag:@"0402"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterTypeStatusOperation
                     cmdFlag:@"0403"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"0410"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"0411"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterMACAddressListOperation
                     cmdFlag:@"0412"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"0418"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"0419"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee00041a00";
    [centralManager addTaskWithTaskID:mk_af_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.af_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKAFSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}



+ (void)af_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"0420"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"0421"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"0422"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"0423"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"0428"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"0429"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"042a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByURLStatusOperation
                     cmdFlag:@"0430"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByURLContentOperation
                     cmdFlag:@"0431"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"0438"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"0439"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBXPBeaconStatusOperation
                     cmdFlag:@"0440"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBXPBeaconMajorRangeOperation
                     cmdFlag:@"0441"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBXPBeaconMinorRangeOperation
                     cmdFlag:@"0442"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBXPBeaconUUIDOperation
                     cmdFlag:@"0443"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPAccFilterStatusOperation
                     cmdFlag:@"0450"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPTHFilterStatusOperation
                     cmdFlag:@"0458"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPDeviceInfoStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPDeviceInfoFilterStatusOperation
                     cmdFlag:@"0460"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"0468"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"0469"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"0470"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"0471"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"0472"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"0473"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterBXPTofStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterBXPTofStatusOperation
                     cmdFlag:@"0478"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterBXPTofMfgCodeListWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterBXPTofMfgCodeListOperation
                     cmdFlag:@"0479"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirStatusOperation
                     cmdFlag:@"0480"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirDetectionStatusOperation
                     cmdFlag:@"0481"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirSensorSensitivityOperation
                     cmdFlag:@"0482"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirDoorStatusOperation
                     cmdFlag:@"0483"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirDelayResponseStatusOperation
                     cmdFlag:@"0484"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirMajorRangeOperation
                     cmdFlag:@"0485"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByPirMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByPirMinorRangeOperation
                     cmdFlag:@"0486"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"04f8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"04f9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"04fa"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)af_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"0500"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanRegionOperation
                     cmdFlag:@"0501"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanModemOperation
                     cmdFlag:@"0502"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"0503"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"0504"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"0505"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanDEVADDROperation
                     cmdFlag:@"0506"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"0507"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"0508"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanClassTypeOperation
                     cmdFlag:@"0509"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"050a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"050b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanCHOperation
                     cmdFlag:@"0520"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanDROperation
                     cmdFlag:@"0521"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"0522"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"0523"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readMulticaseGroupStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadMulticaseGroupStatusOperation
                     cmdFlag:@"0530"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readMcAddrWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadMcAddrOperation
                     cmdFlag:@"0531"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readMcAppSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadMcAppSkeyOperation
                     cmdFlag:@"0532"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readMcNwkSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadMcNwkSkeyOperation
                     cmdFlag:@"0533"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"0540"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"0541"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readDeviceInfoMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadDeviceInfoMessageTypeOperation
                     cmdFlag:@"0550"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readHeartbeatMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadHeartbeatMessageTypeOperation
                     cmdFlag:@"0551"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readLowPowerMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadLowPowerMessageTypeOperation
                     cmdFlag:@"0552"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readEventMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadEventMessageTypeOperation
                     cmdFlag:@"0554"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBeaconMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBeaconMessageTypeOperation
                     cmdFlag:@"055c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAlarmMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAlarmMessageTypeOperation
                     cmdFlag:@"055e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Other application***********************
+ (void)af_readTHFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTHFunctionStatusOperation
                     cmdFlag:@"0650"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTHSampleRateWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTHSampleRateOperation
                     cmdFlag:@"0651"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark *************************Scan Params***********************
+ (void)af_readScanReportStrategiesWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadScanReportStrategiesOperation
                     cmdFlag:@"0701"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadDuplicateDataFilterOperation
                     cmdFlag:@"0702"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readDataRetentionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadDataRetentionStrategyOperation
                     cmdFlag:@"0703"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readReportDataMaxLengthWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadReportDataMaxLengthOperation
                     cmdFlag:@"0704"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPUploadBroadcastWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPUploadBroadcastOperation
                     cmdFlag:@"0705"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAlarmDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAlarmDuplicateDataFilterOperation
                     cmdFlag:@"0706"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAlarmDuplicateDataCycleWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAlarmDuplicateDataCycleOperation
                     cmdFlag:@"0707"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readAlarmSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadAlarmSwitchStatusOperation
                     cmdFlag:@"0708"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimingScanImmediatelyReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimingScanImmediatelyReportDurationOperation
                     cmdFlag:@"0710"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimingScanImmediatelyReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimingScanImmediatelyReportTimePointOperation
                     cmdFlag:@"0711"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPeriodicScanImmediatelyReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPeriodicScanImmediatelyReportParamsOperation
                     cmdFlag:@"0718"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readScanAlwaysOnPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadScanAlwaysOnPeriodicReportIntervalOperation
                     cmdFlag:@"0720"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPeriodicScanPeriodicReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPeriodicScanPeriodicReportParamsOperation
                     cmdFlag:@"0728"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readScanAlwaysOnTimingReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadScanAlwaysOnTimingReportTimePointOperation
                     cmdFlag:@"0730"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimingScanTimingReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimingScanTimingReportDurationOperation
                     cmdFlag:@"0738"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimingScanTimingReportScanTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimingScanTimingReportScanTimePointOperation
                     cmdFlag:@"0739"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTimingScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                     failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTimingScanTimingReportReportTimePointOperation
                     cmdFlag:@"073a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPeriodicScanTimingReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPeriodicScanTimingReportParamsOperation
                     cmdFlag:@"0740"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readPeriodicScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                       failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadPeriodicScanTimingReportReportTimePointOperation
                     cmdFlag:@"0741"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBeaconContentOperation
                     cmdFlag:@"0750"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readUIDContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadUIDContentOperation
                     cmdFlag:@"0751"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadURLContentOperation
                     cmdFlag:@"0752"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readTLMContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadTLMContentOperation
                     cmdFlag:@"0753"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPACCContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPACCContentOperation
                     cmdFlag:@"0754"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPTHContentWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPTHContentOperation
                     cmdFlag:@"0755"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPDeviceInfoContentWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPDeviceInfoContentOperation
                     cmdFlag:@"0756"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPTagContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPTagContentOperation
                     cmdFlag:@"0757"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPTofContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPTofContentOperation
                     cmdFlag:@"0759"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPPirContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPPirContentOperation
                     cmdFlag:@"075a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPBeaconContentOperation
                     cmdFlag:@"075b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readBXPButtonContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadBXPButtonContentOperation
                     cmdFlag:@"075c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readOtherTypeContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadOtherTypeContentOperation
                     cmdFlag:@"0770"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)af_readOtherBlockOptionsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_af_taskReadOtherBlockOptionsOperation
                     cmdFlag:@"0771"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_af_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.af_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end

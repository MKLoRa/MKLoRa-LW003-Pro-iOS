//
//  MKAFInterface.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFInterface : NSObject

#pragma mark ******************Device Service Information**********************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************System***********************

/// Read the mac address of the device.
/*
 @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the low power status of the device.
/*
 @{
    @"status":@"0",     //@"0":No low power status  @"1":Low power status
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/*
 @{
    @"interval":@"60",      //Unit:min
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Settings.
/*
 @{
    @"lowPower":@(YES),
    @"charged":@(YES),
    @"broadcast":@(NO)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Turn off Device by button.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTurnOffDeviceByButtonStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Shut-Down Payload.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readShutDownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError * error))failedBlock;

/// Continuity Transfer Function.(*When the device encounters network disconnection or power failure, whether continue to transfer the data that hadn't been uploaded before when it is connected to the network or powered up again.)
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readContinuityTransferFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read battery voltage.
/*
 @{
 @"voltage":@"3000",        //Unit:mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the PCBA Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Selftest Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the temperature.
/*
 @{
 @"isOn":@(YES),        //Whether the function is open. If this function is close, the temperature will be empty.
 @"temperature":@"20",        //Unit:℃
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTemperatureWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the humidity.
/*
 @{
 @"isOn":@(YES),        //Whether the function is open. If this function is close, the humidity will be empty.
 @"humidity":@"20",        //Unit:%
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readHumidityWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the solar borad's charging current.
/*
 @{
 @"current":@"20",        //Unit:mA
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readSolarBoardChargingCurrentWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark **************************************** Battery ************************************************

/// Current Cycle Battery Information.
/*
 @{
     @"workTimes":@"65535",         //Device working times.(Unit:s)
     @"advCount":@"65535",          //The number of Bluetooth broadcasts by the device.
     @"scanTime":@"65535".          //The bluetooth scan duration.(Unit:s)
     @"redIndicateTotalTime":@"65535".          //The red indicate light operates total time.(Unit:s)
     @"greenIndicateTotalTime":@"65535".          //The green indicate light operates total time.(Unit:s)
     @"blueIndicateTotalTime":@"65535".          //The blue indicate light operates total time.(Unit:s)
     @"axisSleepTimes":@"11111",       //Three-axis sensor sleep times.(Unit:s)
     @"axisWakeupTimes":@"11111",       //Three-axis sensor wake-up times.(Unit:s)
     @"loraSendCount":@"10000",     //Number of LoRaWAN transmissions.
     @"loraPowerConsumption":@"50000",      //Power consumption of LoRaWAN sending and receiving data.(Unit:mAS)
     @"batteryPower":@"33500"       //Total battery power consumption.(Unit:0.001mAH)
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Last Cycle Battery Information.
/*
 @{
 @"workTimes":@"65535",         //Device working times.(Unit:s)
 @"advCount":@"65535",          //The number of Bluetooth broadcasts by the device.
 @"scanTime":@"65535".          //The bluetooth scan duration.(Unit:s)
 @"redIndicateTotalTime":@"65535".          //The red indicate light operates total time.(Unit:s)
 @"greenIndicateTotalTime":@"65535".          //The green indicate light operates total time.(Unit:s)
 @"blueIndicateTotalTime":@"65535".          //The blue indicate light operates total time.(Unit:s)
 @"axisSleepTimes":@"11111",       //Three-axis sensor sleep times.(Unit:s)
 @"axisWakeupTimes":@"11111",       //Three-axis sensor wake-up times.(Unit:s)
 @"loraSendCount":@"10000",     //Number of LoRaWAN transmissions.
 @"loraPowerConsumption":@"50000",      //Power consumption of LoRaWAN sending and receiving data.(Unit:mAS)
 @"batteryPower":@"33500"       //Total battery power consumption.(Unit:0.001mAH)
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLastCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// All Cycles Battery Information.
/*
 @{
 @"workTimes":@"65535",         //Device working times.(Unit:s)
 @"advCount":@"65535",          //The number of Bluetooth broadcasts by the device.
 @"scanTime":@"65535".          //The bluetooth scan duration.(Unit:s)
 @"redIndicateTotalTime":@"65535".          //The red indicate light operates total time.(Unit:s)
 @"greenIndicateTotalTime":@"65535".          //The green indicate light operates total time.(Unit:s)
 @"blueIndicateTotalTime":@"65535".          //The blue indicate light operates total time.(Unit:s)
 @"axisSleepTimes":@"11111",       //Three-axis sensor sleep times.(Unit:s)
 @"axisWakeupTimes":@"11111",       //Three-axis sensor wake-up times.(Unit:s)
 @"loraSendCount":@"10000",     //Number of LoRaWAN transmissions.
 @"loraPowerConsumption":@"50000",      //Power consumption of LoRaWAN sending and receiving data.(Unit:mAS)
 @"batteryPower":@"33500"       //Total battery power consumption.(Unit:0.001mAH)
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.(LW011-MT only)
/*
    @{
    @"prompt":@"0",         //@"0":10%   @"1":20%   @"2":30%    @"3":40%    @"4":50% 
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to trigger a heartbeat when the device is low on battery.
/*
    @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power information packet reporting interval in low power state.
/*
 @{
    @"interval":@"30",  //Unit:x30mins
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerPayloadIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Automatically power on after charging.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAutoPowerOnAfterChargingWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Voltage Threshold.
/*
 @{
    @"threshold":@"58",  //Unit:0.05v   58=2.9v
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerNonChargeVoltageThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Min. Sample Interval.
/*
 @{
    @"interval":@"60",  //Unit:mins
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerNonChargeMinSampleIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Sample Times.
/*
 @{
    @"times":@"10",  //Unit:times
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerNonChargeSampleTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;


/// Charging Priority.(Only for LW003-B-PRO-C)
/*
 @{
 @"priority":@"0",  //@"0":DC Priority  @"1":Solar Priority
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readChargingPriorityWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Ble Params***********************
/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast timeout time in Bluetooth configuration mode.
/*
 @{
 @"timeout":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Adv Interval of the device.
/*
 @{
 @"interval":@"1",      //Unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0dBm"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Scan Fliter***********************
/// Read the Scanning Type/PHY.
/*
 @{
    @"phyType":@"0",            //0:1M PHY (BLE 4.x)      1:1M PHY (BLE 5)    2:1M PHY (BLE 4.x + BLE 5)     3:Coded PHY(BLE 5)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":Only MAC
 @"2":Only ADV Name
 @"3":Only Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read switch status of filtered device types.
/*
 @{
     @"iBeacon":@(YES),
     @"uid":@(YES),
     @"url":@(YES),
     @"tlm":@(YES),
     @"bxp_beacon":@(YES),
     @"bxp_deviceInfo":@(YES),
     @"bxp_acc":@(YES),
     @"bxp_th":@(YES),
     @"bxp_button":@(YES),
     @"bxp_tag":@(YES),
     @"other":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/*
 @{
 @"namespaceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/*
 @{
 @"instanceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/*
 @{
 @"url":@"moko.com"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/*
 @{
 @"version":@"0",           //@"0":Null(Do not filter data)   @"1":Unencrypted TLM data. @"2":Encrypted TLM data.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Button Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Alarm Filter status of the BXP Button Info.
/*
 @{
     @"singlePresse":@(YES),
     @"doublePresse":@(YES),
     @"longPresse":@(YES),
     @"abnormal":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-TagID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-TagID addresses.
/*
 @{
 @"tagIDList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-TOF equipment filter switch.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterBXPTofStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-TOF equipment filter MFG code.
/*
    @{
    @"codeList":@[@"AABB",@"CCDD"]
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterBXPTofMfgCodeListWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-PIR.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Detection Status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0: No motion detected  1:Motion detected   2:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Sensor Sensitivity of filter by MK-PIR.
/*
 @{
 @"sensitivity":@"0",            //0:Low 1:Medium 2:High 3:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Door status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0:Close  1:Open  2:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Delay response status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0:Low delay     1:Medium delay      2:High delay   3:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of MK-PIR.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of MK-PIR.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByPirMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/*
 @{
 @"relationship":@"0",
 }
  0:A
  1:A & B
  2:A | B
  3:A & B & C
  4:(A & B) | C
  5:A | B | C
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter.
/*
 @{
    @"conditionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
                @"data":@"001122"
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
                @"data":@"0011"
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ************************ LoRaWAN ***********************
/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the class type of the LoRaWAN.
/*
 0:ClassA
 1:ClassB   Currently not supported
 2:ClassC
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK LIMIT Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK DELAY Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.It is only used for US915,AU915,CN470.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Uplink Strategy  Of Lorawan.
/*
 @{
 @"isOn":@(isOn),
 @"transmissions":transmissions,
 @"DRL":DRL,            //DR For Payload Low.
 @"DRH":DRH,            //DR For Payload High.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.It is only used for EU868,CN779, EU433 and RU864.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group switch status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readMulticaseGroupStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group address.
/*
 @{
    @"mcAddr":@"11223344"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readMcAddrWithSucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group APPSKEY.
/*
 @{
    @"appSkey":@"2B7E151628AED2A6ABF7158809CF4F3C"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readMcAppSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read multicase group NWKSKEY.
/*
 @{
    @"nwkSkey":@"2B7E151628AED2A6ABF7158809CF4F3C"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readMcNwkSkeyWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan devtime command synchronization interval.(Hour)
/*
 @{
    @"interval":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Network Check Interval Of Lorawan.(Hour)
/*
 @{
    @"interval":@"55"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Device Information Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readDeviceInfoMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Heartbeat Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readHeartbeatMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Low-Power Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readLowPowerMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Event Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readEventMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Beacon Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBeaconMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Alarm Payload Message Type Settings.
/*
 @{
     @"payloadType":@"0",           //@"0":Unconfirmed   @"1":Confirmed
     @"number":@"1",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAlarmMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Other application***********************
/// Temperature and humidity sampling switch status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTHFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature and humidity sampling frequency.
/*
 @{
    @"sampleRate":@"1",     //Unit:Min.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTHSampleRateWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Scan Params***********************

/// Scan & Report Strategies.
/*
 @{
    @"strategy":@"0",
 }
 @"0":No Scan & No Report
 @"1":Timing Scan & Immediately Report
 @"2":Periodic Scan & Immediately Report
 @"3":Scan Always On & Periodic Report
 @"4":Periodic Scan & Periodic Report
 @"5":Scan Always On & Timing Report
 @"6":Timing Scan & Timing Report
 @"7":Periodic Scan & Timing Report
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readScanReportStrategiesWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Duplicate Data Filter.
/*
 @{
    @"filter":@"0",
 }
 
 @"0":None
 @"1":MAC
 @"2":MAC+Data Type
 @"3":MAC+Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Data retention strategy when the report interval isn't enough to upload all the data for the current reporting cycle.
/*
 @{
    @"strategy":@"0",           //@"0":Current Cycle Priority   @"1":Next Cycle Priority
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readDataRetentionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Report Data Max Length.
/*
 @{
    @"level":@"0",          //@"0":Level 1(115 Bytes)   @"1":Level 2(242 Bytes)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readReportDataMaxLengthWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP devices can upload broadcast datas independently.
/*
 @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPUploadBroadcastWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Duplicate Data Filter.
/*
 @{
    @"filter":@"0",
 }
 
 @"0":None
 @"1":MAC
 @"2":MAC+Data Type
 @"3":MAC+Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAlarmDuplicateDataFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Duplicate Data judge cycle.
/*
 @{
    @"cycle":@"1",  //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAlarmDuplicateDataCycleWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm function switch status.
/*
 @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readAlarmSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Duration).
/*
 @{
    @"duration":@"5",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimingScanImmediatelyReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Time Point).
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimingScanImmediatelyReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Immediately Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/*
 @{
    @"duration":@"5",            //Unit:S
    @"interval":@"10",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPeriodicScanImmediatelyReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock;

/// Scan Always On & Periodic Report.(Report Interval)
/*
 @{
    @"interval":@"5",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readScanAlwaysOnPeriodicReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Periodic Report(Bluetooth Scan Duration & Bluetooth Scan Interval & Report Interval).
/*
 @{
    @"scanDuration":@"5",            //Unit:S
    @"scanInterval":@"10",       //Unit:S
    @"reportInterval":@"10",     //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPeriodicScanPeriodicReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock;


/// Scan Always On & Timing Report.
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readScanAlwaysOnTimingReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth scan duration.)
/*
 @{
    @"duration":@"10",          //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimingScanTimingReportDurationWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth Scan Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimingScanTimingReportScanTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError * error))failedBlock;

/// Timing Scan & Timing Report.(Report Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTimingScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                     failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Timing Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/*
 @{
    @"duration":@"5",            //Unit:S
    @"interval":@"10",           //Unit:S
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPeriodicScanTimingReportParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Periodic Scan & Timing Report.(Report Time Point.)
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:10, 2:20, 3:30 4:40 5:50
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readPeriodicScanTimingReportReportTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                                       failedBlock:(void (^)(NSError * error))failedBlock;



/// Content reported by iBeacon data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"uuid":@(YES),
 @"major":@(NO),
 @"minor":@(NO),
 @"measured":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-UID data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"measured":@(YES),
 @"namespaceID":@(YES),
 @"instanceID":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readUIDContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-URL data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"measured":@(YES),
 @"url":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by EddyStone-TLM data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"version":@(NO),
 @"battery":@(NO),
 @"temperature""@(YES),
 @"ADV_CNT":@(YES),
 @"SEC_CNT":(YES)
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readTLMContentWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-ACC data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"sampleRate":@(YES),
 @"fullScale":@(YES),
 @"motionThreshold":@(NO),
 @"axisData":@(YES),
 @"battery":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPACCContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-TH data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"temperature":@(YES),
 @"humidity":@(YES),
 @"battery":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPTHContentWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-deviceInfo data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"txPower":@(YES),
 @"rangingData":@(NO),
 @"advInterval":@(NO),
 @"battery":@(YES),
 @"deviceProperty":@(YES),
 @"switchStatus":@(NO),
 @"firmwareVersion":@(YES),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPDeviceInfoContentWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-Tag data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"sensorStatus":@(YES),
 @"hallCount":@(YES),
 @"motionCount":@(YES),
 @"axisData":@(YES),
 @"temperature":@(YES),
 @"humidity":@(YES),
 @"battery":@(YES),
 @"tagID":@(YES),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPTagContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-Tof data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"mfg":@(YES),
 @"beacon":@(YES),
 @"battery":@(YES),
 @"ranging":@(YES),
 @"user":@(YES),
 @"subType":@(NO),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPTofContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-Pir data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"pirDelayResponse":@(YES),
 @"doorStatus":@(YES),
 @"sensorSensitivity":@(YES),
 @"sensorDetection":@(YES),
 @"battery":@(YES),
 @"major":@(NO),
 @"minor":@(YES),
 @"rssi1m":@(YES),
 @"deviceName":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPPirContentWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by BXP-iBeacon data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"uuid":@(YES),
 @"major":@(NO),
 @"minor":@(NO),
 @"measured":@(YES),
 @"txPower":@(YES),
 @"advInterval":@(NO),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPBeaconContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;


/// Content reported by BXP-Button data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"frameType":@(YES),
 @"statusFlag":@(YES),
 @"triggerCount":@(YES),
 @"deviceID":@(YES),
 @"firmwareType":@(firmwareType),
 @"deviceName":@(YES),
 @"fullScale":@(YES),
 @"motionThreshold":@(YES),
 @"axisData":@(YES),
 @"temperature":@(YES),
 @"rangingData":@(YES),
 @"battery":@(YES),
 @"txPower":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readBXPButtonContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by Other Type data.
/*
 @{
 @"macAddress":@(YES),          //Report
 @"rssi":@(NO),                 //No Report
 @"timestamp":@(YES),
 @"advertising":@(NO),
 @"response":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readOtherTypeContentWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Content reported by Other Type  Block Options data.
/*
 @{
    @"optionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readOtherBlockOptionsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END

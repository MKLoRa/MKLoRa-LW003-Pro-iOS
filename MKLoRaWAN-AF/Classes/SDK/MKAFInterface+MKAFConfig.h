//
//  MKAFInterface+MKAFConfig.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFInterface.h"

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFInterface (MKAFConfig)

#pragma mark ******************System****************

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/// @param interval 1Min~14400Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configHeartbeatInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Indicator Settings.
/// @param lowPower Low battery indicator switch status.
/// @param charged Charging indicator switch status.
/// @param broadcast Bluetooth broadcast indicator switch status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configIndicatorSettings:(BOOL)lowPower
                           charged:(BOOL)charged
                         broadcast:(BOOL)broadcast
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Turn off Device by button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTurnOffDeviceByButtonStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Shut-Down Payload.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configShutDownPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Continuity Transfer Function.(*When the device encounters network disconnection or power failure, whether continue to transfer the data that hadn't been uploaded before when it is connected to the network or powered up again.)
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configContinuityTransferFunctionStatus:(BOOL)isOn
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark **************************************** Battery ************************************************


/// Battery Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_batteryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.(LW011-MT only)
/// @param prompt prompt
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerPrompt:(mk_af_lowPowerPrompt)prompt
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to trigger a heartbeat when the device is low on battery.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power information packet reporting interval in low power state.
/// @param interval 1×30mins ~ 255×30mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerPayloadInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Automatically power on after charging.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAutoPowerOnAfterCharging:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Voltage Threshold.
/// @param threshold 44~64,unit:0.05v. 44=2.2v, 64=3.2v.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerNonChargeVoltageThreshold:(NSInteger)threshold
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Min. Sample Interval.
/// @param interval 1Min~1440Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerNonChargeMinSampleInterval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Low Power Non-charge Sample Times.
/// @param times 1~100.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerNonChargeSampleTimes:(NSInteger)times
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;


/// Charging Priority.(Only for LW003-B-PRO-C)
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configChargingPriority:(mk_af_charingPriority)priority
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Ble Params***********************
/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast timeout time in Bluetooth configuration mode.
/// @param timeout 1Min~60Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBroadcastTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBeaconStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Adv Interval of the device.
/// @param interval 1 x 100ms ~ 100 x 100ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTxPower:(mk_af_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 0~20 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Scan Fliter***********************

/// Configure the Scanning Type/PHY.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configScanningPHYType:(mk_af_PHYMode)mode
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// The device will uplink valid ADV data with RSSI no less than rssi dBm.
/// @param rssi -127 dBm ~ 0 dBm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterRelationship:(mk_af_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByMacPreciseMatch:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByMacReverseFilter:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByAdvNamePreciseMatch:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByAdvNameReverseFilter:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of Adv Name.
/// @param nameList You can set up to 10 filters.1-20 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBeaconStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBeaconMajorWithMinValue:(NSInteger)minValue
                                        maxValue:(NSInteger)maxValue
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBeaconMinorWithMinValue:(NSInteger)minValue
                                        maxValue:(NSInteger)maxValue
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBeaconUUID:(NSString *)uuid
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByUIDStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/// @param namespaceID 0~10 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByUIDNamespaceID:(NSString *)namespaceID
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/// @param instanceID 0~6 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByUIDInstanceID:(NSString *)instanceID
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByURLStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/// @param content 0~100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByURLContent:(NSString *)content
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByTLMStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/// @param version version
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByTLMVersion:(mk_af_filterByTLMVersion)version
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPBeaconStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPBeaconMajorWithMinValue:(NSInteger)minValue
                                           maxValue:(NSInteger)maxValue
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPBeaconMinorWithMinValue:(NSInteger)minValue
                                           maxValue:(NSInteger)maxValue
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPBeaconUUID:(NSString *)uuid
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-ACC device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPAccFilterStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-T&H device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPTHFilterStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Device Info.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPDeviceInfoStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPButtonStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button type filter content.
/// @param singlePress Filter Single Press alarm message switch.
/// @param doublePress Filter Double Press alarm message switch
/// @param longPress Filter Long Press alarm message switch
/// @param abnormalInactivity Abnormal Inactivity
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPButtonAlarmStatus:(BOOL)singlePress
                                  doublePress:(BOOL)doublePress
                                    longPress:(BOOL)longPress
                           abnormalInactivity:(BOOL)abnormalInactivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-T&S TagID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByBXPTagIDStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPreciseMatchTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configReverseFilterTagIDStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-T&S TagID.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterBXPTagIDList:(NSArray <NSString *>*)tagIDList
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-Tof.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByTofStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-Tof.
/// @param codeList You can set up to 10 filters.1-2 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterBXPTofList:(NSArray <NSString *>*)codeList
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-PIR.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Detection Status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirDetectionStatus:(mk_af_detectionStatus)status
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Sensor Sensitivity of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirSensorSensitivity:(mk_af_sensorSensitivity)sensitivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Door status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirDoorStatus:(mk_af_doorStatus)status
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Delay response status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirDelayResponseStatus:(mk_af_delayResponseStatus)status
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of MK-PIR.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirMajorMinValue:(NSInteger)minValue
                                 maxValue:(NSInteger)maxValue
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of MK-PIR.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param failedBlock Failure callback
+ (void)af_configFilterByPirMinorMinValue:(NSInteger)minValue
                                 maxValue:(NSInteger)maxValue
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByOtherStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByOtherRelationship:(mk_af_filterByOther)relationship
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter conditions.
/// @param conditions conditions
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configFilterByOtherConditions:(NSArray <mk_af_BLEFilterRawDataProtocol>*)conditions
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *******************设备lorawan信息设置*********************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configRegion:(mk_af_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configModem:(mk_af_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the class type of the LoRaWAN.
/// @param classType classType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configClassType:(mk_af_loraWanClassType)classType
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)af_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param transmissions 1/2
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configUplinkStrategy:(BOOL)isOn
                  transmissions:(NSInteger)transmissions
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK LIMIT Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLorawanADRACKLimit:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK DELAY Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLorawanADRACKDelay:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure multicase group switch status.
/// @param isOn isOn.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configMulticaseGroupStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the McAddr of multicase group.
/// @param mcAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configMcADDR:(NSString *)mcAddr
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of multicase group.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configMcAPPSKEY:(NSString *)appSkey
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of multicase group.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configMcNWKSKEY:(NSString *)nwkSkey
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Device Information Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDeviceInfoPayloadType:(mk_af_messageType)messageType
                maxRetransmissionTimes:(NSInteger)times
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configHeartbeatPayloadType:(mk_af_messageType)messageType
               maxRetransmissionTimes:(NSInteger)times
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Low-Power Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configLowPowerPayloadType:(mk_af_messageType)messageType
              maxRetransmissionTimes:(NSInteger)times
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Event Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configEventPayloadType:(mk_af_messageType)messageType
           maxRetransmissionTimes:(NSInteger)times
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBeaconPayloadType:(mk_af_messageType)messageType
            maxRetransmissionTimes:(NSInteger)times
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAlarmPayloadType:(mk_af_messageType)messageType
           maxRetransmissionTimes:(NSInteger)times
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Gateway Connect Payload Message Type Settings.
/// @param messageType messageType
/// @param times Max Retransmission Times.1~4.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configGatewayPayloadType:(mk_af_messageType)messageType
             maxRetransmissionTimes:(NSInteger)times
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Other application***********************
/// Temperature and humidity sampling switch status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTHFunctionStatus:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature and humidity sampling frequency.
/// @param sampleRate 1Min ~ 10 Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTHSampleRate:(NSInteger)sampleRate
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Scan Params***********************

/// Scan & Report Strategies.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configScanReportStrategy:(mk_af_scanReportStrategy)strategy
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Duplicate Data Filter.
/// @param filter filter
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDuplicateDataFilter:(mk_af_duplicateDataFilter)filter
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Data retention strategy when the report interval isn't enough to upload all the data for the current reporting cycle.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configDataRetentionStrategy:(mk_af_dataRetentionStrategy)strategy
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Report Data Max Length.
/// @param level level
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configReportDataMaxLength:(mk_af_reportDataMaxLengthType)level
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP devices can upload broadcast datas independently.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPUploadBroadcastStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Duplicate Data Filter.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAlarmDuplicateDataFilter:(mk_af_duplicateDataFilter)strategy
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm Duplicate Data judge cycle.
/// @param cycle 1s ~ 5s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAlarmDuplicateDataCycle:(NSInteger)cycle
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Alarm function switch status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configAlarmSwitchStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Duration).
/// @param duration 3s ~ 65535s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimingScanImmediatelyReportDuration:(NSInteger)duration
                                            sucBlock:(void (^)(void))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Immediately Report(Bluetooth Scan Time Point).
/// @param dataList up to 48 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimingScanImmediatelyReportTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList
                                             sucBlock:(void (^)(void))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic Scan & Immediately Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/// @param duration Bluetooth Scan Duration, 3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param interval Bluetooth Scan Interval,3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPeriodicScanImmediatelyReportDuration:(NSInteger)duration
                                              interval:(NSInteger)interval
                                              sucBlock:(void (^)(void))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Scan Always On & Periodic Report.(Report Interval)
/// @param interval 3s ~ 65535s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configScanAlwaysOnPeriodicReportInterval:(NSInteger)interval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic Scan & Immediately Report(Bluetooth Scan Duration & Bluetooth Scan Interval & Report Duration).
/// @param scanDuration Bluetooth Scan Duration, 3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param scanInterval Bluetooth Scan Interval,3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param reportInterval Report Interval,3s ~ 65535s.The Report Interval shouldn't be less than Bluetooth Scan Interval.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPeriodicScanPeriodicReportDuration:(NSInteger)scanDuration
                                       scanInterval:(NSInteger)scanInterval
                                     reportInterval:(NSInteger)reportInterval
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Scan Always On & Timing Report.
/// @param dataList up to 24 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configScanAlwaysOnTimingReportTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth scan duration.)
/// @param duration 3s~65535s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimingScanTimingReportDuration:(NSInteger)duration
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Timing Report.(Bluetooth Scan Time Point.)
/// @param dataList up to 48 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimingScanTimingReportScanTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList
                                            sucBlock:(void (^)(void))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Timing Scan & Timing Report.(Report Scan Time Point.)
/// @param dataList up to 24 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTimingScanTimingReportReportTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList
                                              sucBlock:(void (^)(void))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic Scan & Timing Report(Bluetooth Scan Duration & Bluetooth Scan Interval).
/// @param duration Bluetooth Scan Duration, 3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param interval Bluetooth Scan Interval,3s ~ 65535s.The Bluetooth Scan Interval shouldn't be less than Bluetooth Scan Duration.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPeriodicScanTimingReportDuration:(NSInteger)duration
                                         interval:(NSInteger)interval
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Periodic Scan & Timing Report.(Report Scan Time Point.)
/// @param dataList up to 24 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configPeriodicScanTimingReportReportTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList
                                                sucBlock:(void (^)(void))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by iBeacon data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBeaconContent:(id <mk_af_beaconContentProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by EddyStone-UID data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configUIDContent:(id <mk_af_uidContentProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by EddyStone-URL data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configURLContent:(id <mk_af_urlContentProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by EddyStone-TLM data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configTLMContent:(id <mk_af_tlmContentProtocol>)protocol
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-ACC data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPACCContent:(id <mk_af_bxpACCContentProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-TH data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPTHContent:(id <mk_af_bxpTHContentProtocol>)protocol
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-Device Info data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPDeviceInfoContent:(id <mk_af_bxpDeviceInfoContentProtocol>)protocol
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-Tag data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPTagContent:(id <mk_af_bxpTagContentProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-Tof data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPTofContent:(id <mk_af_bxpTofContentProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-Pir data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPPirContent:(id <mk_af_bxpPirContentProtocol>)protocol
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-iBeacon data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPBeaconContent:(id <mk_af_bxpBeaconContentProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by BXP-Button data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configBXPButtonContent:(id <mk_af_bxpButtonContentProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by Other Type data.
/// @param protocol protocol
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configOtherTypeContent:(id <mk_af_baseContentProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Content reported by Other Type  Block Options data.
/// @param options options.Max:10
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_configOtherBlockOptions:(NSArray <mk_af_otherTypeBlockDataProtocol>*)options
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark *************************Storage*********************************
/// Read the data stored by the device every day.
/// @param days 1 ~ 65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_readNumberOfDaysStoredData:(NSInteger)days
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Clear all data stored in the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_clearAllDatasWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Pause/resume data transmission of local data.
/// @param pause YES:pause,NO:resume
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)af_pauseSendLocalData:(BOOL)pause
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END

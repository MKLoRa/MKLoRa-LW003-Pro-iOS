#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKAFCentralManager

typedef NS_ENUM(NSInteger, mk_af_centralConnectStatus) {
    mk_af_centralConnectStatusUnknow,                                           //未知状态
    mk_af_centralConnectStatusConnecting,                                       //正在连接
    mk_af_centralConnectStatusConnected,                                        //连接成功
    mk_af_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_af_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_af_centralManagerStatus) {
    mk_af_centralManagerStatusUnable,                           //不可用
    mk_af_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_af_repoweredDefaultMode) {
    mk_af_repoweredDefaultMode_offMode,             //Off mode
    mk_af_repoweredDefaultMode_onMode,              //On mode
    mk_af_repoweredDefaultMode_revertToLastMode,    //Revert To Last Mode
};

typedef NS_ENUM(NSInteger, mk_af_lowPowerPrompt) {
    mk_af_lowPowerPrompt_tenPercent,
    mk_af_lowPowerPrompt_twentyPercent,
    mk_af_lowPowerPrompt_thirtyPercent,
    mk_af_lowPowerPrompt_fortyPercent,
    mk_af_lowPowerPrompt_FiftyPercent,
};

typedef NS_ENUM(NSInteger, mk_af_detectionStatus) {
    mk_af_detectionStatus_noMotionDetected,
    mk_af_detectionStatus_motionDetected,
    mk_af_detectionStatus_all
};

typedef NS_ENUM(NSInteger, mk_af_sensorSensitivity) {
    mk_af_sensorSensitivity_low,
    mk_af_sensorSensitivity_medium,
    mk_af_sensorSensitivity_high,
    mk_af_sensorSensitivity_all
};

typedef NS_ENUM(NSInteger, mk_af_doorStatus) {
    mk_af_doorStatus_close,
    mk_af_doorStatus_open,
    mk_af_doorStatus_all
};

typedef NS_ENUM(NSInteger, mk_af_delayResponseStatus) {
    mk_af_delayResponseStatus_low,
    mk_af_delayResponseStatus_medium,
    mk_af_delayResponseStatus_high,
    mk_af_delayResponseStatus_all
};

typedef NS_ENUM(NSInteger, mk_af_loraWanRegion) {
    mk_af_loraWanRegionAS923,
    mk_af_loraWanRegionAU915,
    mk_af_loraWanRegionEU868,
    mk_af_loraWanRegionKR920,
    mk_af_loraWanRegionIN865,
    mk_af_loraWanRegionUS915,
    mk_af_loraWanRegionRU864,
    mk_af_loraWanRegionAS923_1,
    mk_af_loraWanRegionAS923_2,
    mk_af_loraWanRegionAS923_3,
    mk_af_loraWanRegionAS923_4,
};

typedef NS_ENUM(NSInteger, mk_af_loraWanModem) {
    mk_af_loraWanModemABP,
    mk_af_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_af_loraWanClassType) {
    mk_af_loraWanClassTypeA,          //Class A.
    mk_af_loraWanClassTypeC,            //Class C.
};

typedef NS_ENUM(NSInteger, mk_af_messageType) {
    mk_af_messageTypeUnconfirmed,          //Unconfirmed.
    mk_af_messageTypeConfirmed,            //Confirmed.
};

typedef NS_ENUM(NSInteger, mk_af_dataRetentionStrategy) {
    mk_af_dataRetentionStrategy_currentCyclePriority,          //Current Cycle Priority.
    mk_af_dataRetentionStrategy_nextCyclePriority,            //Next Cycle Priority.
};

typedef NS_ENUM(NSInteger, mk_af_reportDataMaxLengthType) {
    mk_af_reportDataMaxLengthType_level1,          //Level 1(115 Bytes).
    mk_af_reportDataMaxLengthType_level2,            //Level 2(242 Bytes).
};

typedef NS_ENUM(NSInteger, mk_af_scanReportStrategy) {
    mk_af_scanReportStrategy_close,                               //No Scan & No Report
    mk_af_scanReportStrategy_timingScanImmediatelyReport,         //Timing Scan & Immediately Report
    mk_af_scanReportStrategy_periodicScanImmediatelyReport,       //Periodic Scan & Immediately Report
    mk_af_scanReportStrategy_scanAlwaysOnPeriodicReport,          //Scan Always On & Periodic Report
    mk_af_scanReportStrategy_periodicScanPeriodicReport,          //Periodic Scan & Periodic Report
    mk_af_scanReportStrategy_scanAlwaysOnTimingReport,            //Scan Always On & Timing Report
    mk_af_scanReportStrategy_timingScanTimingReport,              //Timing Scan & Timing Report
    mk_af_scanReportStrategy_periodicScanTimingReport,            //Periodic Scan & Timing Report
};

typedef NS_ENUM(NSInteger, mk_af_filterByOther) {
    mk_af_filterByOther_A,                 //Filter by A condition.
    mk_af_filterByOther_AB,                //Filter by A & B condition.
    mk_af_filterByOther_AOrB,              //Filter by A | B condition.
    mk_af_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_af_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_af_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_af_txPower) {
    mk_af_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_af_txPowerNeg20dBm,   //-20dBm
    mk_af_txPowerNeg16dBm,   //-16dBm
    mk_af_txPowerNeg12dBm,   //-12dBm
    mk_af_txPowerNeg8dBm,    //-8dBm
    mk_af_txPowerNeg4dBm,    //-4dBm
    mk_af_txPower0dBm,       //0dBm
    mk_af_txPower2dBm,       //2dBm
    mk_af_txPower3dBm,       //3dBm
    mk_af_txPower4dBm,       //4dBm
    mk_af_txPower5dBm,       //5dBm
    mk_af_txPower6dBm,       //6dBm
    mk_af_txPower7dBm,       //7dBm
    mk_af_txPower8dBm,       //8dBm
};

typedef NS_ENUM(NSInteger, mk_af_duplicateDataFilter) {
    mk_af_duplicateDataFilter_none,             //None
    mk_af_duplicateDataFilter_mac,              //MAC
    mk_af_duplicateDataFilter_macAndDataType,   //MAC+Data Type
    mk_af_duplicateDataFilter_macAndRawData,    //MAC+Raw Data
};

typedef NS_ENUM(NSInteger, mk_af_PHYMode) {
    mk_af_PHYMode_BLE4,                     //1M PHY (BLE 4.x)
    mk_af_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_af_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.x + BLE 5)
    mk_af_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_af_filterRelationship) {
    mk_af_filterRelationship_null,
    mk_af_filterRelationship_mac,
    mk_af_filterRelationship_advName,
    mk_af_filterRelationship_rawData,
    mk_af_filterRelationship_advNameAndRawData,
    mk_af_filterRelationship_macAndadvNameAndRawData,
    mk_af_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_af_filterByTLMVersion) {
    mk_af_filterByTLMVersion_null,             //Do not filter data.
    mk_af_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_af_filterByTLMVersion_1,                //Encrypted TLM data.
};

typedef NS_ENUM(NSInteger, mk_af_charingPriority) {
    mk_af_charingPriority_DC,
    mk_af_charingPriority_solar,
};

@protocol mk_af_scanTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:10   2:20   3:30    4:40   5:50
@property (nonatomic, assign)NSInteger minuteGear;

@end

@protocol mk_af_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@end

@protocol mk_af_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

#pragma mark - ***********************Content Protocol************************

@protocol mk_af_baseContentProtocol <NSObject>

/// YES:Report.     NO:Not Reported.
@property (nonatomic, assign)BOOL macAddress;

@property (nonatomic, assign)BOOL rssi;

@property (nonatomic, assign)BOOL timestamp;


@property (nonatomic, assign)BOOL advertising;

@property (nonatomic, assign)BOOL response;

@end



@protocol mk_af_beaconContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL uuid;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

/// Measured RSSI@1M
@property (nonatomic, assign)BOOL measured;

@end


@protocol mk_af_uidContentProtocol <mk_af_baseContentProtocol>

/// RSSI@0M
@property (nonatomic, assign)BOOL measured;

@property (nonatomic, assign)BOOL namespaceID;

@property (nonatomic, assign)BOOL instanceID;

@end

@protocol mk_af_urlContentProtocol <mk_af_baseContentProtocol>

/// RSSI@0M
@property (nonatomic, assign)BOOL measured;

@property (nonatomic, assign)BOOL url;

@end

@protocol mk_af_tlmContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL version;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL ADV_CNT;

@property (nonatomic, assign)BOOL SEC_CNT;

@end


@protocol mk_af_bxpBeaconContentProtocol <mk_af_beaconContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL advInterval;

@end


@protocol mk_af_bxpDeviceInfoContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL deviceProperty;

@property (nonatomic, assign)BOOL switchStatus;

@property (nonatomic, assign)BOOL firmwareVersion;

@property (nonatomic, assign)BOOL deviceName;

@end


@protocol mk_af_bxpACCContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL sampleRate;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL battery;

@end



@protocol mk_af_bxpTHContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL txPower;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL advInterval;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL humidity;

@property (nonatomic, assign)BOOL battery;

@end



@protocol mk_af_bxpButtonContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL frameType;

@property (nonatomic, assign)BOOL statusFlag;

@property (nonatomic, assign)BOOL triggerCount;

@property (nonatomic, assign)BOOL deviceID;

@property (nonatomic, assign)BOOL firmwareType;

@property (nonatomic, assign)BOOL deviceName;

@property (nonatomic, assign)BOOL fullScale;

@property (nonatomic, assign)BOOL motionThreshold;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL temperature;

@property (nonatomic, assign)BOOL rangingData;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL txPower;

@end



@protocol mk_af_bxpTagContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL sensorStatus;

@property (nonatomic, assign)BOOL hallCount;

@property (nonatomic, assign)BOOL motionCount;

@property (nonatomic, assign)BOOL axisData;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL tagID;

@property (nonatomic, assign)BOOL deviceName;

@end

@protocol mk_af_bxpTofContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL mfg;

@property (nonatomic, assign)BOOL beacon;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL ranging;

@property (nonatomic, assign)BOOL user;

@property (nonatomic, assign)BOOL subType;

@property (nonatomic, assign)BOOL deviceName;

@end

@protocol mk_af_bxpPirContentProtocol <mk_af_baseContentProtocol>

@property (nonatomic, assign)BOOL pirDelayResponse;

@property (nonatomic, assign)BOOL doorStatus;

@property (nonatomic, assign)BOOL sensorSensitivity;

@property (nonatomic, assign)BOOL sensorDetection;

@property (nonatomic, assign)BOOL battery;

@property (nonatomic, assign)BOOL major;

@property (nonatomic, assign)BOOL minor;

@property (nonatomic, assign)BOOL rssi1m;

@property (nonatomic, assign)BOOL deviceName;

@end


@protocol mk_af_otherTypeBlockDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.1~29.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.minIndex~29.
@property (nonatomic, assign)NSInteger maxIndex;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_af_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-40),
 @"peripheral":peripheral,
 @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
 @"deviceType":@"00",
 @"txPower":txPower,
 @"battery":@"100",
 @"voltage":@"3.333V",
 @"needPassword":@(YES),
 @"temperature":@"10.05",
 @"humidity":@"-10.22",
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_af_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_af_startScan;

/// Stops scanning equipment.
- (void)mk_af_stopScan;

@end

@protocol mk_af_storageDataDelegate <NSObject>

- (void)mk_af_receiveStorageData:(NSString *)content;

@end


@protocol mk_af_centralManagerLogDelegate <NSObject>

- (void)mk_af_receiveLog:(NSString *)deviceLog;

@end

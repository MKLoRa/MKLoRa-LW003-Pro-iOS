
typedef NS_ENUM(NSInteger, mk_af_taskOperationID) {
    mk_af_defaultTaskOperationID,
    
#pragma mark - Read
    mk_af_taskReadDeviceModelOperation,        //读取产品型号
    mk_af_taskReadFirmwareOperation,           //读取固件版本
    mk_af_taskReadHardwareOperation,           //读取硬件类型
    mk_af_taskReadSoftwareOperation,           //读取软件版本
    mk_af_taskReadManufacturerOperation,       //读取厂商信息
    mk_af_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_af_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 系统参数
    mk_af_taskReadMacAddressOperation,          //读取Mac地址
    mk_af_taskReadLowPowerStatusOperation,      //读取低电状态
    mk_af_taskReadTimeZoneOperation,            //读取时区
    mk_af_taskReadHeartbeatIntervalOperation,   //读取心跳间隔
    mk_af_taskReadIndicatorSettingsOperation,   //读取指示灯开关
    mk_af_taskReadTurnOffDeviceByButtonStatusOperation,         //读取按键关机功能
    mk_af_taskReadShutDownPayloadStatusOperation,               //读取关机信息包开关
    mk_af_taskReadContinuityTransferFunctionStatusOperation,        //定期断电续传功能开关
    mk_af_taskReadBatteryVoltageOperation,              //读取电池电压
    mk_af_taskReadPCBAStatusOperation,              //读取产测状态
    mk_af_taskReadSelftestStatusOperation,          //读取自检故障原因
    mk_af_taskReadTemperatureOperation,             //读取温度
    mk_af_taskReadHumidityOperation,                //读取湿度
    mk_af_taskReadSolarBoardChargingCurrentOperation,   //读取太阳能板充电电流
    
#pragma mark - 电池管理参数
    mk_af_taskReadBatteryInformationOperation,      //读取电池电量消耗
    mk_af_taskReadLastCycleBatteryInformationOperation, //读取上一周期电池电量消耗
    mk_af_taskReadAllCycleBatteryInformationOperation,  //读取所有周期电池电量消耗
    mk_af_taskReadLowPowerPromptOperation,          //读取低电百分比
    mk_af_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_af_taskReadLowPowerPayloadIntervalOperation,     //读取低电状态下低电信息包上报间隔
    mk_af_taskReadAutoPowerOnAfterChargingOperation,    //读取充电自动开机功能
    mk_af_taskReadLowPowerNonChargeVoltageThresholdOperation,   //读取不可充电电池:低电电压值
    mk_af_taskReadLowPowerNonChargeMinSampleIntervalOperation,  //读取不可充电电池:最小采样间隔
    mk_af_taskReadLowPowerNonChargeSampleTimesOperation,        //读取不可充电电池:低电检测采样次数
    mk_af_taskReadChargingPriorityOperation,            //读取充电优先级
    
#pragma mark - 蓝牙参数
    mk_af_taskReadConnectationNeedPasswordOperation,    //读取是否需要连接密码
    mk_af_taskReadPasswordOperation,            //读取连接密码
    mk_af_taskReadBroadcastTimeoutOperation,    //读取广播超时时长
    mk_af_taskReadBeaconStatusOperation,        //读取Beacon模式开关
    mk_af_taskReadAdvIntervalOperation,         //读取广播间隔
    mk_af_taskReadTxPowerOperation,             //读取Tx Power
    mk_af_taskReadDeviceNameOperation,          //读取广播名称
    
#pragma mark - 扫描过滤参数
    mk_af_taskReadScanningPHYTypeOperation,             //读取扫描PHY过滤
    mk_af_taskReadRssiFilterValueOperation,             //读取RSSI过滤规则
    mk_af_taskReadFilterRelationshipOperation,          //读取广播内容过滤逻辑
    mk_af_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_af_taskReadFilterByMacPreciseMatchOperation, //读取精准过滤MAC开关
    mk_af_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_af_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_af_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_af_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_af_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_af_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_af_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_af_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_af_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_af_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_af_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_af_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_af_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_af_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_af_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_af_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_af_taskReadFilterByBXPBeaconStatusOperation,      //读取BXP-iBeacon类型过滤开关
    mk_af_taskReadFilterByBXPBeaconMajorRangeOperation,    //读取BXP-iBeacon类型Major范围
    mk_af_taskReadFilterByBXPBeaconMinorRangeOperation,    //读取BXP-iBeacon类型Minor范围
    mk_af_taskReadFilterByBXPBeaconUUIDOperation,          //读取BXP-iBeacon类型UUID
    mk_af_taskReadBXPAccFilterStatusOperation,          //读取BeaconX Pro-ACC设备过滤开关
    mk_af_taskReadBXPTHFilterStatusOperation,           //读取BeaconX Pro-T&H设备过滤开关
    mk_af_taskReadBXPDeviceInfoFilterStatusOperation,       //读取BXP-DeviceInfo过滤条件开关
    mk_af_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_af_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_af_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-T&S TagID类型开关
    mk_af_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-T&S TagID类型精准过滤tagID开关
    mk_af_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-T&S TagID类型反向过滤tagID开关
    mk_af_taskReadFilterBXPTagIDListOperation,             //读取BXP-T&S TagID过滤规则
    mk_af_taskReadFilterBXPTofStatusOperation,              //读取BXP-TOF设备过滤开关
    mk_af_taskReadFilterBXPTofMfgCodeListOperation,         //读取BXP-TOF设备过滤MFG code
    mk_af_taskReadFilterByPirStatusOperation,           //读取PIR过滤开关
    mk_af_taskReadFilterByPirDetectionStatusOperation,  //读取PIR设备过滤sensor_detection_status
    mk_af_taskReadFilterByPirSensorSensitivityOperation,    //读取PIR设备过滤sensor_sensitivity
    mk_af_taskReadFilterByPirDoorStatusOperation,           //读取PIR设备过滤door_status
    mk_af_taskReadFilterByPirDelayResponseStatusOperation,  //读取PIR设备过滤delay_response_status
    mk_af_taskReadFilterByPirMajorRangeOperation,           //读取PIR设备Major过滤范围
    mk_af_taskReadFilterByPirMinorRangeOperation,           //读取PIR设备Minor过滤范围
    mk_af_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_af_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_af_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    
#pragma mark - 设备LoRa参数读取
    mk_af_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_af_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_af_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_af_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_af_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_af_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_af_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_af_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_af_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_af_taskReadLorawanClassTypeOperation,        //读取LoRaWAN ClassType
    mk_af_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_af_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_af_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_af_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_af_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_af_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_af_taskReadMulticaseGroupStatusOperation,            //读取组播开关
    mk_af_taskReadMcAddrOperation,                          //读取组播地址
    mk_af_taskReadMcAppSkeyOperation,                       //读取组播APPSKEY
    mk_af_taskReadMcNwkSkeyOperation,                        //读取组播NWKSKEY
    mk_af_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_af_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_af_taskReadDeviceInfoMessageTypeOperation,       //读取设备信息包上行配置
    mk_af_taskReadHeartbeatMessageTypeOperation,        //读取心跳包上行配置
    mk_af_taskReadLowPowerMessageTypeOperation,         //读取低电信息包上行配置
    mk_af_taskReadEventMessageTypeOperation,            //读取事件信息包上行配置
    mk_af_taskReadBeaconMessageTypeOperation,           //读取网关信息包上行配置
    mk_af_taskReadAlarmMessageTypeOperation,            //读取报警信息包上行配置
    mk_af_taskReadGatewayMessageTypeOperation,          //读取网关信息包上行配置
    
#pragma mark - 其他应用功能
    mk_af_taskReadTHFunctionStatusOperation,                    //读取温湿度采样开关
    mk_af_taskReadTHSampleRateOperation,                        //读取温湿度采样间隔
    
#pragma mark - 扫描参数
    mk_af_taskReadScanReportStrategiesOperation,        //读取扫描上报策略
    mk_af_taskReadDuplicateDataFilterOperation,         //读取重复数据过滤规则
    mk_af_taskReadDataRetentionStrategyOperation,       //读取扫描数据保留策略
    mk_af_taskReadReportDataMaxLengthOperation,         //读取扫描数据最大上报长度
    mk_af_taskReadBXPUploadBroadcastOperation,          //读取BXP设备可单独上报广播报
    mk_af_taskReadAlarmDuplicateDataFilterOperation,    //读取报警数据重复数据过滤规则
    mk_af_taskReadAlarmDuplicateDataCycleOperation,     //读取报警数据重复数据判定周期
    mk_af_taskReadAlarmSwitchStatusOperation,           //读取报警功能开关
    mk_af_taskReadTimingScanImmediatelyReportDurationOperation,                 //读取定时扫描&立即上报扫描时长
    mk_af_taskReadTimingScanImmediatelyReportTimePointOperation,                //读取定时扫描&立即上报定时扫描时间
    mk_af_taskReadPeriodicScanImmediatelyReportParamsOperation,                 //读取定期扫描&立即上报扫描参数
    mk_af_taskReadScanAlwaysOnPeriodicReportIntervalOperation,                  //读取扫描常开&定期上报上报间隔
    mk_af_taskReadPeriodicScanPeriodicReportParamsOperation,                    //读取定期扫描定期上报扫描参数
    mk_af_taskReadScanAlwaysOnTimingReportTimePointOperation,                   //读取扫描常开&定时上报定时上报时间
    mk_af_taskReadTimingScanTimingReportDurationOperation,                      //读取定时扫描&定时上报扫描时长
    mk_af_taskReadTimingScanTimingReportScanTimePointOperation,                 //读取定时扫描&定时上报定时扫描时间
    mk_af_taskReadTimingScanTimingReportReportTimePointOperation,               //读取定时扫描&定时上报定时上报时间
    mk_af_taskReadPeriodicScanTimingReportParamsOperation,                      //读取定期扫描&定时上报扫描参数
    mk_af_taskReadPeriodicScanTimingReportReportTimePointOperation,             //读取定期扫描&定时上报定时上报时间
    mk_af_taskReadBeaconContentOperation,               //读取iBeacon上报内容
    mk_af_taskReadUIDContentOperation,                  //读取UID上报内容
    mk_af_taskReadURLContentOperation,                  //读取URL上报内容
    mk_af_taskReadTLMContentOperation,                  //读取TLM上报内容
    mk_af_taskReadBXPACCContentOperation,               //读取BXP-ACC上报内容
    mk_af_taskReadBXPTHContentOperation,                //读取BXP-T&H上报内容
    mk_af_taskReadBXPDeviceInfoContentOperation,        //读取BXP-DeviceInfo上报内容
    mk_af_taskReadBXPTagContentOperation,               //读取BXP-Tag上报内容
    mk_af_taskReadBXPTofContentOperation,               //读取BXP-Tof上报内容
    mk_af_taskReadBXPPirContentOperation,               //读取BXP-Pir上报内容
    mk_af_taskReadBXPBeaconContentOperation,            //读取BXP-iBeacon上报内容
    mk_af_taskReadBXPButtonContentOperation,            //读取BXP-Button上报内容
    mk_af_taskReadOtherTypeContentOperation,            //读取Other Type Content
    mk_af_taskReadOtherBlockOptionsOperation,           //读取Ohter Type Block Options
    
#pragma mark - 系统参数配置
    mk_af_taskPowerOffOperation,                //设备关机
    mk_af_taskRestartDeviceOperation,           //设备重启
    mk_af_taskFactoryResetOperation,            //恢复出厂设置
    mk_af_taskConfigDeviceTimeOperation,        //配置时间
    mk_af_taskConfigTimeZoneOperation,          //配置时区
    mk_af_taskConfigHeartbeatIntervalOperation, //配置心跳间隔
    mk_af_taskConfigIndicatorSettingsOperation,             //配置指示灯开关
    mk_af_taskConfigTurnOffDeviceByButtonStatusOperation,           //配置按键关机功能开关
    mk_af_taskConfigShutDownPayloadStatusOperation,                 //配置关机信息包开关
    mk_af_taskConfigContinuityTransferFunctionStatusOperation,      //配置断电续传功能
    
#pragma mark - 电池管理
    mk_af_taskBatteryResetOperation,                    //清除电池电量数据
    mk_af_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_af_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_af_taskConfigLowPowerPayloadIntervalOperation,   //配置低电状态下低电信息包上报间隔
    mk_af_taskConfigAutoPowerOnAfterChargingOperation,  //配置充电自动开机功能
    mk_af_taskConfigLowPowerNonChargeVoltageThresholdOperation, //配置不可充电电池:低电电压值
    mk_af_taskConfigLowPowerNonChargeMinSampleIntervalOperation,    //配置不可充电电池:最小采样间隔
    mk_af_taskConfigLowPowerNonChargeSampleTimesOperation,          //配置不可充电电池:低电检测采样次数
    mk_af_taskConfigChargingPriorityOperation,          //配置充电优先级
    
#pragma mark - 蓝牙参数
    mk_af_taskConfigNeedPasswordOperation,              //读取蓝牙密码开关
    mk_af_taskConfigPasswordOperation,                  //读取蓝牙连接密码
    mk_af_taskConfigBroadcastTimeoutOperation,          //读取广播超时时长
    mk_af_taskConfigBeaconStatusOperation,              //配置Beacon模式开关
    mk_af_taskConfigAdvIntervalOperation,               //读取广播间隔
    mk_af_taskConfigTxPowerOperation,                   //读取Tx Power
    mk_af_taskConfigDeviceNameOperation,                //读取广播名称
    
#pragma mark - 扫描过滤参数
    mk_af_taskConfigScanningPHYTypeOperation,                   //配置扫描PHY过滤
    mk_af_taskConfigRssiFilterValueOperation,           //配置rssi过滤规则
    mk_af_taskConfigFilterRelationshipOperation,        //配置广播内容过滤逻辑
    mk_af_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_af_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_af_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_af_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_af_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_af_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_af_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_af_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_af_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_af_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_af_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_af_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_af_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_af_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_af_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_af_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_af_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_af_taskConfigFilterByBXPBeaconStatusOperation,          //配置BXP-iBeacon类型过滤开关
    mk_af_taskConfigFilterByBXPBeaconMajorOperation,           //配置BXP-iBeacon类型过滤的Major范围
    mk_af_taskConfigFilterByBXPBeaconMinorOperation,           //配置BXP-iBeacon类型过滤的Minor范围
    mk_af_taskConfigFilterByBXPBeaconUUIDOperation,            //配置BXP-iBeacon类型过滤的UUID
    mk_af_taskConfigBXPAccFilterStatusOperation,            //配置BeaconX Pro-ACC设备过滤开关
    mk_af_taskConfigBXPTHFilterStatusOperation,             //配置BeaconX Pro-TH设备过滤开关
    mk_af_taskConfigFilterByBXPDeviceInfoStatusOperation,       //配置BXP-DeviceInfo过滤开关
    mk_af_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_af_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_af_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-T&S TagID类型过滤开关
    mk_af_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-T&S TagID类型精准过滤Tag-ID开关
    mk_af_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-T&S TagID类型反向过滤Tag-ID开关
    mk_af_taskConfigFilterBXPTagIDListOperation,                //配置BXP-T&S TagID过滤规则
    mk_af_taskConfigFilterByTofStatusOperation,                 //配置BXP-TOF设备过滤开关
    mk_af_taskConfigFilterBXPTofListOperation,                  //配置BXP-TOF设备过滤开关
    mk_af_taskConfigFilterByPirStatusOperation,             //配置PIR设备过滤开关
    mk_af_taskConfigFilterByPirDetectionStatusOperation,    //配置PIR设备过滤sensor_detection_status
    mk_af_taskConfigFilterByPirSensorSensitivityOperation,  //配置PIR设备过滤sensor_sensitivity
    mk_af_taskConfigFilterByPirDoorStatusOperation,         //配置PIR设备过滤door_status
    mk_af_taskConfigFilterByPirDelayResponseStatusOperation,    //配置PIR设备过滤delay_response_status
    mk_af_taskConfigFilterByPirMajorOperation,                  //配置PIR设备Major过滤范围
    mk_af_taskConfigFilterByPirMinorOperation,                  //配置PIR设备Minor过滤范围
    mk_af_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_af_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_af_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表
    
#pragma mark - 设备LoRa参数配置
    mk_af_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_af_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_af_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_af_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_af_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_af_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_af_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_af_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_af_taskConfigClassTypeOperation,                 //配置LoRaWAN ClassType
    mk_af_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_af_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_af_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_af_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_af_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_af_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_af_taskConfigMulticaseGroupStatusOperation,      //配置组播开关
    mk_af_taskConfigMcADDROperation,                    //配置组播地址
    mk_af_taskConfigMcAPPSKEYOperation,                 //配置组播APPSKEY
    mk_af_taskConfigMcNWKSKEYOperation,                 //配置组播NWKSKEY
    mk_af_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_af_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_af_taskConfigDeviceInfoPayloadTypeOperation,     //配置设备信息包上行参数
    mk_af_taskConfigHeartbeatPayloadTypeOperation,      //配置心跳包上行参数
    mk_af_taskConfigLowPowerPayloadTypeOperation,       //配置低电信息包上行配置
    mk_af_taskConfigEventPayloadTypeOperation,          //配置事件信息包上行参数
    mk_af_taskConfigBeaconPayloadTypeOperation,         //配置Beacon信息包上行参数
    mk_af_taskConfigAlarmPayloadTypeOperation,          //配置报警信息包上行配置
    mk_af_taskConfigGatewayPayloadTypeOperation,        //配置网关信息包上行配置
    
#pragma mark - 其他应用参数
    mk_af_taskConfigTHFunctionStatusOperation,              //读取温湿度采样开关
    mk_af_taskConfigTHSampleRateOperation,                  //读取温湿度采样频率
    
#pragma mark - 扫描参数
    mk_af_taskConfigScanReportStrategyOperation,        //配置扫描上报策略
    mk_af_taskConfigDuplicateDataFilterOperation,               //配置重复数据过滤规则
    mk_af_taskConfigDataRetentionStrategyOperation,     //配置扫描数据保留策略
    mk_af_taskConfigReportDataMaxLengthOperation,       //配置扫描数据最大上报长度
    mk_af_taskConfigBXPUploadBroadcastStatusOperation,  //配置BXP设备可单独上报广播包
    mk_af_taskConfigAlarmDuplicateDataFilterOperation,  //配置报警数据重复数据过滤规则
    mk_af_taskConfigAlarmDuplicateDataCycleOperation,   //配置报警数据重复数据判定周期
    mk_af_taskConfigAlarmSwitchStatusOperation,         //配置报警功能开关
    mk_af_taskConfigTimingScanImmediatelyReportDurationOperation,           //配置定时扫描&立即上报扫描时长
    mk_af_taskConfigTimingScanImmediatelyReportTimePointOperation,          //配置定时扫描&立即上报定时扫描时间
    mk_af_taskConfigPeriodicScanImmediatelyReportParamsOperation,           //配置定期扫描&立即上报参数
    mk_af_taskConfigScanAlwaysOnPeriodicReportIntervalOperation,           //配置扫描常开&定期上报上报间隔
    mk_af_taskConfigPeriodicScanPeriodicReportParamsOperation,              //配置定期扫描定期上报扫描参数
    mk_af_taskConfigScanAlwaysOnTimingReportTimePointOperation,             //配置扫描常开&定时上报定时上报时间
    mk_af_taskConfigTimingScanTimingReportDurationOperation,                //配置定时扫描&定时上报扫描时长
    mk_af_taskConfigTimingScanTimingReportScanTimePointOperation,           //配置定时扫描&定时上报定时扫描时间
    mk_af_taskConfigTimingScanTimingReportReportTimePointOperation,         //配置定时扫描&定时上报定时上报时间
    mk_af_taskConfigPeriodicScanTimingReportParamsOperation,                //配置定期扫描&定时上报扫描参数
    mk_af_taskConfigPeriodicScanTimingReportReportTimePointOperation,       //配置定期扫描&定时上报定时上报时间
    mk_af_taskConfigBeaconContentOperation,             //配置iBeacon上报内容
    mk_af_taskConfigUIDContentOperation,                //配置UID上报内容
    mk_af_taskConfigURLContentOperation,                //配置URL上报内容
    mk_af_taskConfigTLMContentOperation,                //配置TLM上报内容
    mk_af_taskConfigBXPACCContentOperation,             //配置BXP-ACC
    mk_af_taskConfigBXPTHContentOperation,              //配置BXP-TH
    mk_af_taskConfigBXPDeviceInfoContentOperation,      //配置BXP-Device Info
    mk_af_taskConfigBXPTagContentOperation,             //配置BXP-Tag
    mk_af_taskConfigBXPTofContentOperation,             //配置BXP-Tof
    mk_af_taskConfigBXPPirContentOperation,             //配置BXP-Pir
    mk_af_taskConfigBXPBeaconContentOperation,          //配置BXP-iBeacon
    mk_af_taskConfigBXPButtonContentOperation,          //配置BXP-Button
    mk_af_taskConfigOtherTypeContentOperation,          //配置Other Type Content
    mk_af_taskConfigOtherBlockOptionsOperation,         //配置Other Block Data
    
#pragma mark - 存储数据协议
    mk_af_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_af_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_af_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
};

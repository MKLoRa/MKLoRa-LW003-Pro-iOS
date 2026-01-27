//
//  MKAFTaskAdopter.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKAFSDKDataAdopter.h"
#import "MKAFOperationID.h"

NSString *const mk_af_totalNumKey = @"mk_af_totalNumKey";
NSString *const mk_af_totalIndexKey = @"mk_af_totalIndexKey";
NSString *const mk_af_contentKey = @"mk_af_contentKey";

@implementation MKAFTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_af_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_af_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_af_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_af_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_af_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 12) {
            state = [content substringWithRange:NSMakeRange(10, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_af_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(8, 2)];
    if (readData.length != dataLen + 5) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    NSString *content = [readString substringWithRange:NSMakeRange(10, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(10, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(12, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_af_taskOperationID operationID = mk_af_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(7, len)];
        NSDictionary *resultDic= @{
            mk_af_totalNumKey:totalNum,
            mk_af_totalIndexKey:index,
            mk_af_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"041a"]) {
            //读取Adv Name过滤规则
            operationID = mk_af_taskReadFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_af_taskOperationID operationID = mk_af_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(8, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"041a"]) {
            //配置Adv Name过滤规则
            operationID = mk_af_taskConfigFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_af_taskOperationID operationID = mk_af_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"0015"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_af_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"0016"]) {
        //读取低电状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerStatusOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_af_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //读取心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //读取指示灯开关
        BOOL lowPower = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
        BOOL charged = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
        BOOL broadcast = [[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"];
        resultDic = @{
            @"lowPower":@(lowPower),
            @"charged":@(charged),
            @"broadcast":@(broadcast),
        };
        operationID = mk_af_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //读取按键关机功能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadTurnOffDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //读取关机信息包开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadShutDownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"002a"]) {
        //读取断电续传功能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadContinuityTransferFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"0040"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"0041"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_af_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"0042"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_af_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"0043"]) {
        //读取温度
        NSString *temperature = @"";
        BOOL isOn = NO;
        if (![content isEqualToString:@"ffff"]) {
            isOn = YES;
            temperature = [NSString stringWithFormat:@"%.2f",[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue] * 0.01];
        }
        resultDic = @{
            @"isOn":@(isOn),
            @"temperature":temperature,
        };
        operationID = mk_af_taskReadTemperatureOperation;
    }else if ([cmd isEqualToString:@"0045"]) {
        //读取湿度
        NSString *humidity = @"";
        BOOL isOn = NO;
        if (![content isEqualToString:@"ffff"]) {
            isOn = YES;
            humidity = [NSString stringWithFormat:@"%.2f",[MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)] * 0.01];
        }
        resultDic = @{
            @"isOn":@(isOn),
            @"humidity":humidity,
        };
        operationID = mk_af_taskReadHumidityOperation;
    }else if ([cmd isEqualToString:@"0046"]) {
        //读取太阳能板充电电流
        NSString *current = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"current":current,
        };
        operationID = mk_af_taskReadSolarBoardChargingCurrentOperation;
    }else if ([cmd isEqualToString:@"0101"]) {
        //读取电池信息
        NSInteger index = 0;
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *scanTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *redIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *greenIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *blueIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisSleepTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisWakeupTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"scanTime":scanTime,
            @"redIndicateTotalTime":redIndicateTotalTime,
            @"greenIndicateTotalTime":greenIndicateTotalTime,
            @"blueIndicateTotalTime":blueIndicateTotalTime,
            @"axisSleepTimes":axisSleepTimes,
            @"axisWakeupTimes":axisWakeupTimes,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_af_taskReadBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0102"]) {
        //读取上一周期电池电量消耗
        NSInteger index = 0;
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *scanTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *redIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *greenIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *blueIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisSleepTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisWakeupTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"scanTime":scanTime,
            @"redIndicateTotalTime":redIndicateTotalTime,
            @"greenIndicateTotalTime":greenIndicateTotalTime,
            @"blueIndicateTotalTime":blueIndicateTotalTime,
            @"axisSleepTimes":axisSleepTimes,
            @"axisWakeupTimes":axisWakeupTimes,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_af_taskReadLastCycleBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0103"]) {
        //读取所有周期电池电量消耗
        NSInteger index = 0;
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *scanTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *redIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *greenIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *blueIndicateTotalTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisSleepTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *axisWakeupTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        index += 8;
        
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"scanTime":scanTime,
            @"redIndicateTotalTime":redIndicateTotalTime,
            @"greenIndicateTotalTime":greenIndicateTotalTime,
            @"blueIndicateTotalTime":blueIndicateTotalTime,
            @"axisSleepTimes":axisSleepTimes,
            @"axisWakeupTimes":axisWakeupTimes,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower
        };
        operationID = mk_af_taskReadAllCycleBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0104"]) {
        //读取低电百分比
        resultDic = @{
            @"prompt":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //读取低电触发心跳开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_af_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //读取低电状态下低电信息包上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"0108"]) {
        //读取充电自动开机功能
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_af_taskReadAutoPowerOnAfterChargingOperation;
    }else if ([cmd isEqualToString:@"010a"]) {
        //读取不可充电电池:低电电压值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerNonChargeVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010b"]) {
        //读取不可充电电池:最小采样间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerNonChargeMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010c"]) {
        //读取不可充电电池:低电检测采样次数
        resultDic = @{
            @"times":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLowPowerNonChargeSampleTimesOperation;
    }else if ([cmd isEqualToString:@"010d"]) {
        //读取充电优先级
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadChargingPriorityOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_af_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_af_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //读取Beacon模式开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //读取设备Tx Power
        NSString *txPower = [MKAFSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_af_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_af_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0400"]) {
        //读取蓝牙扫描phy选择
        resultDic = @{
            @"phyType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)]
        };
        operationID = mk_af_taskReadScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"0401"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue]],
        };
        operationID = mk_af_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"0402"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"0403"]) {
        //读取过滤设备类型开关
        BOOL other = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL iBeacon = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL uid = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL url = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        BOOL tlm = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        BOOL bxp_acc = ([[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"]);
        BOOL bxp_th = ([[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"]);
        BOOL bxp_ts = ([[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"]);
        BOOL bxp_deviceInfo = ([[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"]);
        BOOL bxp_button = ([[content substringWithRange:NSMakeRange(18, 2)] isEqualToString:@"01"]);
        BOOL bxp_pir = ([[content substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"01"]);
        BOOL bxp_tof = ([[content substringWithRange:NSMakeRange(22, 2)] isEqualToString:@"01"]);
        BOOL bxp_beacon = ([[content substringWithRange:NSMakeRange(24, 2)] isEqualToString:@"01"]);
        
        resultDic = @{
            @"other":@(other),
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"bxp_ts":@(bxp_ts),
            @"bxp_deviceInfo":@(bxp_deviceInfo),
            @"bxp_button":@(bxp_button),
            @"bxp_pir":@(bxp_pir),
            @"bxp_tof":@(bxp_tof),
            @"bxp_beacon":@(bxp_beacon),
        };
        operationID = mk_af_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"0410"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0411"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0412"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKAFSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_af_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"0418"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0419"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0420"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0421"]) {
        //读取iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0422"]) {
        //读取iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"0423"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_af_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0428"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"0429"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_af_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"042a"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_af_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"0430"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"0431"]) {
        //读取URL类型过滤内容
        NSString *url = @"";
        if (content.length > 0) {
            NSData *urlData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
            url = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"url":(MKValidStr(url) ? url : @""),
        };
        operationID = mk_af_taskReadFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"0438"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"0439"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_af_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"0440"]) {
        //读取BXP-iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0441"]) {
        //读取BXP-iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByBXPBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0442"]) {
        //读取BXP-iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByBXPBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"0443"]) {
        //读取BXP-iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_af_taskReadFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0450"]) {
        //读取BeaconX Pro-ACC设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0458"]) {
        //读取BeaconX Pro-T&H设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0460"]) {
        //读取BXP-DeviceInfo类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBXPDeviceInfoFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0468"]) {
        //读取BXP-Button过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBXPButtonFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0469"]) {
        //读取BXP-Button报警过滤开关
        BOOL singlePresse = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL doublePresse = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL longPresse = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL abnormal = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"singlePresse":@(singlePresse),
            @"doublePresse":@(doublePresse),
            @"longPresse":@(longPresse),
            @"abnormal":@(abnormal),
        };
        operationID = mk_af_taskReadBXPButtonAlarmFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0470"]) {
        //读取BXP-T&S TagID类型开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0471"]) {
        //读取BXP-T&S TagID类型精准过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0472"]) {
        //读取读取BXP-T&S TagID类型反向过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0473"]) {
        //读取BXP-T&S TagID过滤规则
        NSArray *tagIDList = [MKAFSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_af_taskReadFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"0478"]) {
        //读取BXP-TOF设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterBXPTofStatusOperation;
    }else if ([cmd isEqualToString:@"0479"]) {
        //读取BXP-TOF设备过滤MFG code
        NSArray *codeList = [MKAFSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"codeList":(MKValidArray(codeList) ? codeList : @[]),
        };
        operationID = mk_af_taskReadFilterBXPTofMfgCodeListOperation;
    }else if ([cmd isEqualToString:@"0480"]) {
        //读取PIR过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"0481"]) {
        //读取PIR设备过滤sensor_detection_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_af_taskReadFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0482"]) {
        //读取PIR设备过滤sensor_sensitivity
        NSString *sensitivity = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"sensitivity":sensitivity,
        };
        operationID = mk_af_taskReadFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"0483"]) {
        //读取PIR设备过滤door_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_af_taskReadFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"0484"]) {
        //读取PIR设备过滤delay_response_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_af_taskReadFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"0485"]) {
        //读取PIR设备Major过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByPirMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0486"]) {
        //读取PIR设备Minor过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_af_taskReadFilterByPirMinorRangeOperation;
    }else if ([cmd isEqualToString:@"04f8"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"04f9"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKAFSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_af_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"04fa"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKAFSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_af_taskReadFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"0500"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_af_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_af_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_af_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_af_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_af_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_af_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"0509"]) {
        //读取LoRaWAN ClassType
        resultDic = @{
            @"classType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanClassTypeOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_af_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_af_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0530"]) {
        //读取组播开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadMulticaseGroupStatusOperation;
    }else if ([cmd isEqualToString:@"0531"]) {
        //读取组播地址
        resultDic = @{
            @"mcAddr":content
        };
        operationID = mk_af_taskReadMcAddrOperation;
    }else if ([cmd isEqualToString:@"0532"]) {
        //读取组播 APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_af_taskReadMcAppSkeyOperation;
    }else if ([cmd isEqualToString:@"0533"]) {
        //读取组播 nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_af_taskReadMcNwkSkeyOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0550"]) {
        //读取设备信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadDeviceInfoMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //读取心跳包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadHeartbeatMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //读取低电信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadLowPowerMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //读取事件信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadEventMessageTypeOperation;
    }else if ([cmd isEqualToString:@"055c"]) {
        //读读取beacon信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadBeaconMessageTypeOperation;
    }else if ([cmd isEqualToString:@"055e"]) {
        //读取报警信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadAlarmMessageTypeOperation;
    }else if ([cmd isEqualToString:@"055f"]) {
        //读取网关信息包上行配置
        NSString *payloadType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"payloadType":payloadType,
            @"number":number,
        };
        operationID = mk_af_taskReadGatewayMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0650"]) {
        //读取温湿度采样开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadTHFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"0651"]) {
        //读取温湿度采样间隔
        resultDic = @{
            @"sampleRate":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadTHSampleRateOperation;
    }else if ([cmd isEqualToString:@"0701"]) {
        //读取扫描上报策略
        resultDic = @{
            @"strategy":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadScanReportStrategiesOperation;
    }else if ([cmd isEqualToString:@"0702"]) {
        //读取重复过滤规则
        resultDic = @{
            @"filter":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"0703"]) {
        //读取扫描数据保留策略
        resultDic = @{
            @"strategy":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadDataRetentionStrategyOperation;
    }else if ([cmd isEqualToString:@"0704"]) {
        //读取扫描数据最大上报长度
        resultDic = @{
            @"level":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadReportDataMaxLengthOperation;
    }else if ([cmd isEqualToString:@"0705"]) {
        //读取BXP设备可单独上报广播报
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadBXPUploadBroadcastOperation;
    }else if ([cmd isEqualToString:@"0706"]) {
        //读取报警数据重复数据过滤规则
        resultDic = @{
            @"filter":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadAlarmDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"0707"]) {
        //读取报警数据重复数据判定周期
        resultDic = @{
            @"cycle":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadAlarmDuplicateDataCycleOperation;
    }else if ([cmd isEqualToString:@"0708"]) {
        //读取报警功能开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_af_taskReadAlarmSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"0710"]) {
        //读取定时扫描&立即上报扫描时长
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadTimingScanImmediatelyReportDurationOperation;
    }else if ([cmd isEqualToString:@"0711"]) {
        //读取定时扫描&立即上报定时扫描时间
        NSArray *list = [MKAFSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_af_taskReadTimingScanImmediatelyReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0718"]) {
        //读取定期扫描&立即上报扫描参数
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"duration":duration,
            @"interval":interval,
        };
        operationID = mk_af_taskReadPeriodicScanImmediatelyReportParamsOperation;
    }else if ([cmd isEqualToString:@"0720"]) {
        //读取扫描常开&定期上报上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadScanAlwaysOnPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0728"]) {
        //读取定期扫描&立即上报扫描参数
        NSString *scanDuration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *scanInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        NSString *reportInterval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 4)];
        resultDic = @{
            @"scanDuration":scanDuration,
            @"scanInterval":scanInterval,
            @"reportInterval":reportInterval,
        };
        operationID = mk_af_taskReadPeriodicScanPeriodicReportParamsOperation;
    }else if ([cmd isEqualToString:@"0730"]) {
        //读取扫描常开&定时上报定时上报时间
        NSArray *list = [MKAFSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_af_taskReadScanAlwaysOnTimingReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0738"]) {
        //读取定时扫描&定时上报扫描时长
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_af_taskReadTimingScanTimingReportDurationOperation;
    }else if ([cmd isEqualToString:@"0739"]) {
        //读取定时扫描&定时上报定时扫描时间
        NSArray *list = [MKAFSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_af_taskReadTimingScanTimingReportScanTimePointOperation;
    }else if ([cmd isEqualToString:@"073a"]) {
        //读取定时扫描&定时上报定时上报时间
        NSArray *list = [MKAFSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_af_taskReadTimingScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0740"]) {
        //读取定期扫描&定时上报扫描参数
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"duration":duration,
            @"interval":interval,
        };
        operationID = mk_af_taskReadPeriodicScanTimingReportParamsOperation;
    }else if ([cmd isEqualToString:@"0741"]) {
        //读取定期扫描&定时上报定时上报时间
        NSArray *list = [MKAFSDKDataAdopter parseScanTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_af_taskReadPeriodicScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0750"]) {
        //读取iBeacon上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL uuid = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL major = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL minor = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL measured = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"uuid":@(uuid),
            @"major":@(major),
            @"minor":@(minor),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBeaconContentOperation;
    }else if ([cmd isEqualToString:@"0751"]) {
        //读取UID上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL measured = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL namespaceID = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL instanceID = [[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"namespaceID":@(namespaceID),
            @"instanceID":@(instanceID),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadUIDContentOperation;
    }else if ([cmd isEqualToString:@"0752"]) {
        //读取URL上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL measured = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL url = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"url":@(url),
            @"measured":@(measured),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadURLContentOperation;
    }else if ([cmd isEqualToString:@"0753"]) {
        //读取TLM上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL version = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL ADV_CNT = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL SEC_CNT = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"version":@(version),
            @"battery":@(battery),
            @"temperature":@(temperature),
            @"ADV_CNT":@(ADV_CNT),
            @"SEC_CNT":@(SEC_CNT),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadTLMContentOperation;
    }else if ([cmd isEqualToString:@"0754"]) {
        //读取BXP-ACC上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL sampleRate = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL fullScale = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL motionThreshold = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"sampleRate":@(sampleRate),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPACCContentOperation;
    }else if ([cmd isEqualToString:@"0755"]) {
        //读取BXP-ACC上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL humidity = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"temperature":@(temperature),
            @"humidity":@(humidity),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPTHContentOperation;
    }else if ([cmd isEqualToString:@"0756"]) {
        //读取BXP-Device Info上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL advInterval = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL deviceProperty = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL switchStatus = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL firmwareVersion = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"txPower":@(txPower),
            @"rangingData":@(rangingData),
            @"advInterval":@(advInterval),
            @"battery":@(battery),
            @"deviceProperty":@(deviceProperty),
            @"switchStatus":@(switchStatus),
            @"firmwareVersion":@(firmwareVersion),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPDeviceInfoContentOperation;
    }else if ([cmd isEqualToString:@"0757"]) {
        //读取BXP-Tag上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL sensorStatus = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL hallCount = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL motionCount = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL humidity = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL tagID = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"sensorStatus":@(sensorStatus),
            @"hallCount":@(hallCount),
            @"motionCount":@(motionCount),
            @"axisData":@(axisData),
            @"temperature":@(temperature),
            @"humidity":@(humidity),
            @"battery":@(battery),
            @"tagID":@(tagID),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPTagContentOperation;
    }else if ([cmd isEqualToString:@"0759"]) {
        //读取BXP-Tof上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL mfg = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL beacon = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL ranging = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL user = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        

        BOOL subType = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"mfg":@(mfg),
            @"beacon":@(beacon),
            @"battery":@(battery),
            @"ranging":@(ranging),
            @"user":@(user),
            @"subType":@(subType),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPTofContentOperation;
    }else if ([cmd isEqualToString:@"075a"]) {
        //读取BXP-Pir上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL pirDelayResponse = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL doorStatus = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL sensorSensitivity = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL sensorDetection = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        

        BOOL major = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL minor = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL rssi1m = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL deviceName = [[binaryHigh substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"pirDelayResponse":@(pirDelayResponse),
            @"doorStatus":@(doorStatus),
            @"sensorSensitivity":@(sensorSensitivity),
            @"sensorDetection":@(sensorDetection),
            @"battery":@(battery),
            @"major":@(major),
            @"minor":@(minor),
            @"rssi1m":@(rssi1m),
            @"deviceName":@(deviceName),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPPirContentOperation;
    }else if ([cmd isEqualToString:@"075b"]) {
        //读取BXP-iBeacon上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL uuid = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL major = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL minor = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL measured = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advInterval = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"uuid":@(uuid),
            @"major":@(major),
            @"minor":@(minor),
            @"measured":@(measured),
            @"txPower":@(txPower),
            @"advInterval":@(advInterval),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPBeaconContentOperation;
    }else if ([cmd isEqualToString:@"075c"]) {
        //读取BXP-Button上报内容
        NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        NSString *binaryCenter = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
        NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(4, 2)]];
        
        BOOL macAddress = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL frameType = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL statusFlag = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL triggerCount = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL deviceID = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL firmwareType = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL deviceName = [[binaryCenter substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL fullScale = [[binaryCenter substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL motionThreshold = [[binaryCenter substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL axisData = [[binaryCenter substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL temperature = [[binaryCenter substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        BOOL rangingData = [[binaryCenter substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        BOOL battery = [[binaryCenter substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
        BOOL txPower = [[binaryCenter substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
        
        BOOL advertising = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL response = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"firmwareType":@(firmwareType),
            @"statusFlag":@(statusFlag),
            @"triggerCount":@(triggerCount),
            @"deviceID":@(deviceID),
            @"frameType":@(frameType),
            @"deviceName":@(deviceName),
            @"fullScale":@(fullScale),
            @"motionThreshold":@(motionThreshold),
            @"axisData":@(axisData),
            @"temperature":@(temperature),
            @"rangingData":@(rangingData),
            @"battery":@(battery),
            @"txPower":@(txPower),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadBXPButtonContentOperation;
    }else if ([cmd isEqualToString:@"0770"]) {
        //读取Other Type Content上报内容
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
        
        BOOL macAddress = [[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL rssi = [[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL advertising = [[binary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL response = [[binary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        
        NSInteger contentValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"macAddress":@(macAddress),
            @"rssi":@(rssi),
            @"timestamp":@(timestamp),
            @"advertising":@(advertising),
            @"response":@(response),
            @"content":@(contentValue),
        };
        operationID = mk_af_taskReadOtherTypeContentOperation;
    }else if ([cmd isEqualToString:@"0771"]) {
        //读取Other Type 数据块上报内容
        NSArray *list = [MKAFSDKDataAdopter parseOtherBlockOptionList:content];
        
        resultDic = @{
            @"optionList":list,
        };
        operationID = mk_af_taskReadOtherBlockOptionsOperation;
    }
    
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_af_taskOperationID operationID = mk_af_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"0000"]) {
        //关机
        operationID = mk_af_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"0001"]) {
        //设备重启
        operationID = mk_af_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"0002"]) {
        //恢复出厂设置
        operationID = mk_af_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"0020"]) {
        //配置时间
        operationID = mk_af_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //配置时区
        operationID = mk_af_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //配置心跳间隔
        operationID = mk_af_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //配置指示灯开关
        operationID = mk_af_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //配置按键关机功能开关
        operationID = mk_af_taskConfigTurnOffDeviceByButtonStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //配置关机信息包开关
        operationID = mk_af_taskConfigShutDownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"002a"]) {
        //配置断电续传功能
        operationID = mk_af_taskConfigContinuityTransferFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"0100"]) {
        //清除电池电量数据
        operationID = mk_af_taskBatteryResetOperation;
    }else if ([cmd isEqualToString:@"0104"]) {
        //配置低电百分比
        operationID = mk_af_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //配置低电触发心跳开关状态
        operationID = mk_af_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //配置低电状态下低电信息包上报间隔
        operationID = mk_af_taskConfigLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"0108"]) {
        //配置充电自动开机功能
        operationID = mk_af_taskConfigAutoPowerOnAfterChargingOperation;
    }else if ([cmd isEqualToString:@"010a"]) {
        //配置不可充电电池:低电电压值
        operationID = mk_af_taskConfigLowPowerNonChargeVoltageThresholdOperation;
    }else if ([cmd isEqualToString:@"010b"]) {
        //配置不可充电电池:最小采样间隔
        operationID = mk_af_taskConfigLowPowerNonChargeMinSampleIntervalOperation;
    }else if ([cmd isEqualToString:@"010c"]) {
        //配置不可充电电池:低电检测采样次数
        operationID = mk_af_taskConfigLowPowerNonChargeSampleTimesOperation;
    }else if ([cmd isEqualToString:@"010d"]) {
        //配置充电优先级
        operationID = mk_af_taskConfigChargingPriorityOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //配置蓝牙连接密码开关
        operationID = mk_af_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //配置蓝牙连接密码
        operationID = mk_af_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //配置广播超时时长
        operationID = mk_af_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //配置Beacon模式开关
        operationID = mk_af_taskConfigBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //配置广播间隔
        operationID = mk_af_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //配置Tx Power
        operationID = mk_af_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //配置广播名称
        operationID = mk_af_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0400"]) {
        //配置扫描PHY过滤
        operationID = mk_af_taskConfigScanningPHYTypeOperation;
    }else if ([cmd isEqualToString:@"0401"]) {
        //配置rssi过滤规则
        operationID = mk_af_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"0402"]) {
        //配置广播内容过滤逻辑
        operationID = mk_af_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"0410"]) {
        //配置精准过滤MAC开关
        operationID = mk_af_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0411"]) {
        //配置反向过滤MAC开关
        operationID = mk_af_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0412"]) {
        //配置MAC过滤规则
        operationID = mk_af_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"0418"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_af_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0419"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_af_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0420"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_af_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0421"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_af_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"0422"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_af_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"0423"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_af_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0428"]) {
        //配置UID类型过滤开关
        operationID = mk_af_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"0429"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_af_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"042a"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_af_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"0430"]) {
        //配置URL类型过滤开关
        operationID = mk_af_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"0431"]) {
        //配置URL类型过滤的内容
        operationID = mk_af_taskConfigFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"0438"]) {
        //配置TLM类型开关
        operationID = mk_af_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"0439"]) {
        //配置TLM过滤数据类型
        operationID = mk_af_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"0440"]) {
        //配置BXP-iBeacon类型过滤开关
        operationID = mk_af_taskConfigFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0441"]) {
        //配置BXP-iBeacon类型过滤Major范围
        operationID = mk_af_taskConfigFilterByBXPBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"0442"]) {
        //配置BXP-iBeacon类型过滤Minor范围
        operationID = mk_af_taskConfigFilterByBXPBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"0443"]) {
        //配置BXP-iBeacon类型过滤UUID
        operationID = mk_af_taskConfigFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0450"]) {
        //配置BeaconX Pro-ACC设备过滤开关
        operationID = mk_af_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0458"]) {
        //配置BeaconX Pro-TH设备过滤开关
        operationID = mk_af_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0460"]) {
        //配置BXP-DeviceInfo过滤开关
        operationID = mk_af_taskConfigFilterByBXPDeviceInfoStatusOperation;
    }else if ([cmd isEqualToString:@"0468"]) {
        //配置BXP-Button过滤开关
        operationID = mk_af_taskConfigFilterByBXPButtonStatusOperation;
    }else if ([cmd isEqualToString:@"0469"]) {
        //配置BXP-Button类型过滤内容
        operationID = mk_af_taskConfigFilterByBXPButtonAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"0470"]) {
        //配置BXP-T&S TagID类型过滤开关
        operationID = mk_af_taskConfigFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0471"]) {
        //配置BXP-T&S TagID类型精准过滤Tag-ID开关
        operationID = mk_af_taskConfigPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0472"]) {
        //配置BXP-T&S TagID类型反向过滤Tag-ID开关
        operationID = mk_af_taskConfigReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0473"]) {
        //配置BXP-T&S TagID过滤规则
        operationID = mk_af_taskConfigFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"0478"]) {
        //配置BXP-TOF设备过滤开关
        operationID = mk_af_taskConfigFilterByTofStatusOperation;
    }else if ([cmd isEqualToString:@"0479"]) {
        //配置BXP-TOF设备过滤开关
        operationID = mk_af_taskConfigFilterBXPTofListOperation;
    }else if ([cmd isEqualToString:@"0480"]) {
        //配置PIR设备过滤开关
        operationID = mk_af_taskConfigFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"0481"]) {
        //配置PIR设备过滤sensor_detection_status
        operationID = mk_af_taskConfigFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0482"]) {
        //配置PIR设备过滤sensor_sensitivity
        operationID = mk_af_taskConfigFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"0483"]) {
        //配置PIR设备过滤door_status
        operationID = mk_af_taskConfigFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"0484"]) {
        //配置PIR设备过滤delay_response_status
        operationID = mk_af_taskConfigFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"0485"]) {
        //配置PIR设备Major过滤范围
        operationID = mk_af_taskConfigFilterByPirMajorOperation;
    }else if ([cmd isEqualToString:@"0486"]) {
        //配置PIR设备Minor过滤范围
        operationID = mk_af_taskConfigFilterByPirMinorOperation;
    }else if ([cmd isEqualToString:@"04f8"]) {
        //配置Other过滤关系开关
        operationID = mk_af_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"04f9"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_af_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"04fa"]) {
        //配置Other过滤条件列表
        operationID = mk_af_taskConfigFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //配置LoRaWAN频段
        operationID = mk_af_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //配置LoRaWAN入网类型
        operationID = mk_af_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_af_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_af_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_af_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_af_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_af_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_af_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"0509"]) {
        //配置LoRaWAN ClassType
        operationID = mk_af_taskConfigClassTypeOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_af_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_af_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //配置LoRaWAN CH
        operationID = mk_af_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //配置LoRaWAN DR
        operationID = mk_af_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_af_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_af_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0530"]) {
        //配置组播开关
        operationID = mk_af_taskConfigMulticaseGroupStatusOperation;
    }else if ([cmd isEqualToString:@"0531"]) {
        //配置组播地址
        operationID = mk_af_taskConfigMcADDROperation;
    }else if ([cmd isEqualToString:@"0532"]) {
        //配置组播APPSKEY
        operationID = mk_af_taskConfigMcAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0533"]) {
        //配置组播NWKSKEY
        operationID = mk_af_taskConfigMcNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_af_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_af_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0550"]) {
        //配置设备信息包上行参数
        operationID = mk_af_taskConfigDeviceInfoPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //配置心跳包上行参数
        operationID = mk_af_taskConfigHeartbeatPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //配置低电信息包上行配置
        operationID = mk_af_taskConfigLowPowerPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //配置事件信息包上行参数
        operationID = mk_af_taskConfigEventPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"055c"]) {
        //配置beacon信息包上行参数
        operationID = mk_af_taskConfigBeaconPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"055e"]) {
        //配置报警信息包上行配置
        operationID = mk_af_taskConfigAlarmPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"055f"]) {
        //配置网关信息包上行配置
        operationID = mk_af_taskConfigGatewayPayloadTypeOperation;
    }else if ([cmd isEqualToString:@"0650"]) {
        //配置温湿度采样开关
        operationID = mk_af_taskConfigTHFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"0651"]) {
        //配置温湿度采样频率
        operationID = mk_af_taskConfigTHSampleRateOperation;
    }else if ([cmd isEqualToString:@"0701"]) {
        //配置扫描上报策略
        operationID = mk_af_taskConfigScanReportStrategyOperation;
    }else if ([cmd isEqualToString:@"0702"]) {
        //配置重复数据过滤规则
        operationID = mk_af_taskConfigDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"0703"]) {
        //配置扫描数据保留策略
        operationID = mk_af_taskConfigDataRetentionStrategyOperation;
    }else if ([cmd isEqualToString:@"0704"]) {
        //配置扫描数据最大上报长度
        operationID = mk_af_taskConfigReportDataMaxLengthOperation;
    }else if ([cmd isEqualToString:@"0705"]) {
        //配置BXP设备可单独上报广播包
        operationID = mk_af_taskConfigBXPUploadBroadcastStatusOperation;
    }else if ([cmd isEqualToString:@"0706"]) {
        //配置报警数据重复数据过滤规则
        operationID = mk_af_taskConfigAlarmDuplicateDataFilterOperation;
    }else if ([cmd isEqualToString:@"0707"]) {
        //配置报警数据重复数据判定周期
        operationID = mk_af_taskConfigAlarmDuplicateDataCycleOperation;
    }else if ([cmd isEqualToString:@"0708"]) {
        //配置报警功能开关
        operationID = mk_af_taskConfigAlarmSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"0710"]) {
        //配置定时扫描&立即上报扫描时长
        operationID = mk_af_taskConfigTimingScanImmediatelyReportDurationOperation;
    }else if ([cmd isEqualToString:@"0711"]) {
        //配置定时扫描&立即上报定时扫描时间
        operationID = mk_af_taskConfigTimingScanImmediatelyReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0718"]) {
        //配置定期扫描&立即上报定时扫描时间
        operationID = mk_af_taskConfigPeriodicScanImmediatelyReportParamsOperation;
    }else if ([cmd isEqualToString:@"0720"]) {
        //配置读取扫描常开&定期上报上报间隔
        operationID = mk_af_taskConfigScanAlwaysOnPeriodicReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0728"]) {
        //配置定期扫描定期上报扫描参数
        operationID = mk_af_taskConfigPeriodicScanPeriodicReportParamsOperation;
    }else if ([cmd isEqualToString:@"0730"]) {
        //配置扫描常开&定时上报定时上报时间
        operationID = mk_af_taskConfigScanAlwaysOnTimingReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0738"]) {
        //配置定时扫描&定时上报扫描时长
        operationID = mk_af_taskConfigTimingScanTimingReportDurationOperation;
    }else if ([cmd isEqualToString:@"0739"]) {
        //配置定时扫描&定时上报定时扫描时间
        operationID = mk_af_taskConfigTimingScanTimingReportScanTimePointOperation;
    }else if ([cmd isEqualToString:@"073a"]) {
        //配置定时扫描&定时上报定时上报时间
        operationID = mk_af_taskConfigTimingScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0740"]) {
        //配置定期扫描&定时上报扫描参数
        operationID = mk_af_taskConfigPeriodicScanTimingReportParamsOperation;
    }else if ([cmd isEqualToString:@"0741"]) {
        //配置定期扫描&定时上报定时上报时间
        operationID = mk_af_taskConfigPeriodicScanTimingReportReportTimePointOperation;
    }else if ([cmd isEqualToString:@"0750"]) {
        //配置iBeacon上报内容
        operationID = mk_af_taskConfigBeaconContentOperation;
    }else if ([cmd isEqualToString:@"0751"]) {
        //配置UID上报内容
        operationID = mk_af_taskConfigUIDContentOperation;
    }else if ([cmd isEqualToString:@"0752"]) {
        //配置URL上报内容
        operationID = mk_af_taskConfigURLContentOperation;
    }else if ([cmd isEqualToString:@"0753"]) {
        //配置TLM上报内容
        operationID = mk_af_taskConfigTLMContentOperation;
    }else if ([cmd isEqualToString:@"0754"]) {
        //配置BXP-ACC上报内容
        operationID = mk_af_taskConfigBXPACCContentOperation;
    }else if ([cmd isEqualToString:@"0755"]) {
        //配置BXP-TH上报内容
        operationID = mk_af_taskConfigBXPTHContentOperation;
    }else if ([cmd isEqualToString:@"0756"]) {
        //配置BXP-Device Info上报内容
        operationID = mk_af_taskConfigBXPDeviceInfoContentOperation;
    }else if ([cmd isEqualToString:@"0757"]) {
        //配置BXP-Tag上报内容
        operationID = mk_af_taskConfigBXPTagContentOperation;
    }else if ([cmd isEqualToString:@"0759"]) {
        //配置BXP-Tof上报内容
        operationID = mk_af_taskConfigBXPTofContentOperation;
    }else if ([cmd isEqualToString:@"075a"]) {
        //配置BXP-Pir上报内容
        operationID = mk_af_taskConfigBXPPirContentOperation;
    }else if ([cmd isEqualToString:@"075b"]) {
        //配置BXP-iBeacon上报内容
        operationID = mk_af_taskConfigBXPBeaconContentOperation;
    }else if ([cmd isEqualToString:@"075c"]) {
        //配置BXP-Button上报内容
        operationID = mk_af_taskConfigBXPButtonContentOperation;
    }else if ([cmd isEqualToString:@"0770"]) {
        //配置Other Type Content
        operationID = mk_af_taskConfigOtherTypeContentOperation;
    }else if ([cmd isEqualToString:@"0771"]) {
        //配置Other Block Data
        operationID = mk_af_taskConfigOtherBlockOptionsOperation;
    }else if ([cmd isEqualToString:@"0900"]) {
        //读取多少天本地存储的数据
        operationID = mk_af_taskReadNumberOfDaysStoredDataOperation;
    }else if ([cmd isEqualToString:@"0901"]) {
        //清除存储的所有数据
        operationID = mk_af_taskClearAllDatasOperation;
    }else if ([cmd isEqualToString:@"0902"]) {
        //暂停/恢复数据传输
        operationID = mk_af_taskPauseSendLocalDataOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_af_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end

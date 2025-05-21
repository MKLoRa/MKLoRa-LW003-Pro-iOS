//
//  MKAFSDKDataAdopter.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKAFSDKDataAdopter

+ (NSString *)fetchRepoweredDefaultModeString:(mk_af_repoweredDefaultMode)mode {
    switch (mode) {
        case mk_af_repoweredDefaultMode_offMode:
            return @"00";
        case mk_af_repoweredDefaultMode_onMode:
            return @"01";
        case mk_af_repoweredDefaultMode_revertToLastMode:
            return @"02";
    }
}

+ (NSString *)fetchLowPowerPromptString:(mk_af_lowPowerPrompt)prompt {
    switch (prompt) {
        case mk_af_lowPowerPrompt_tenPercent:
            return @"00";
        case mk_af_lowPowerPrompt_twentyPercent:
            return @"01";
        case mk_af_lowPowerPrompt_thirtyPercent:
            return @"02";
        case mk_af_lowPowerPrompt_fortyPercent:
            return @"03";
        case mk_af_lowPowerPrompt_FiftyPercent:
            return @"04";
    }
}

+ (NSString *)lorawanRegionString:(mk_af_loraWanRegion)region {
    switch (region) {
        case mk_af_loraWanRegionAS923:
            return @"00";
        case mk_af_loraWanRegionAU915:
            return @"01";
        case mk_af_loraWanRegionEU868:
            return @"05";
        case mk_af_loraWanRegionKR920:
            return @"06";
        case mk_af_loraWanRegionIN865:
            return @"07";
        case mk_af_loraWanRegionUS915:
            return @"08";
        case mk_af_loraWanRegionRU864:
            return @"09";
        case mk_af_loraWanRegionAS923_1:
            return @"0a";
        case mk_af_loraWanRegionAS923_2:
            return @"0b";
        case mk_af_loraWanRegionAS923_3:
            return @"0c";
        case mk_af_loraWanRegionAS923_4:
            return @"0d";
    }
}

+ (NSString *)fetchTxPower:(mk_af_txPower)txPower {
    switch (txPower) {
        case mk_af_txPower8dBm:
            return @"08";
        case mk_af_txPower7dBm:
            return @"07";
        case mk_af_txPower6dBm:
            return @"06";
        case mk_af_txPower5dBm:
            return @"05";
        case mk_af_txPower4dBm:
            return @"04";
        case mk_af_txPower3dBm:
            return @"03";
        case mk_af_txPower2dBm:
            return @"02";
        case mk_af_txPower0dBm:
            return @"00";
        case mk_af_txPowerNeg4dBm:
            return @"fc";
        case mk_af_txPowerNeg8dBm:
            return @"f8";
        case mk_af_txPowerNeg12dBm:
            return @"f4";
        case mk_af_txPowerNeg16dBm:
            return @"f0";
        case mk_af_txPowerNeg20dBm:
            return @"ec";
        case mk_af_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"08"]) {
        return @"8dBm";
    }
    if ([content isEqualToString:@"07"]) {
        return @"7dBm";
    }
    if ([content isEqualToString:@"06"]) {
        return @"6dBm";
    }
    if ([content isEqualToString:@"05"]) {
        return @"5dBm";
    }
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"02"]) {
        return @"2dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

+ (NSString *)fetchMessageTypeString:(mk_af_messageType)messageType {
    switch (messageType) {
        case mk_af_messageTypeUnconfirmed:
            return @"00";
        case mk_af_messageTypeConfirmed:
            return @"01";
    }
}

+ (NSString *)fetchDataRetentionStrategyString:(mk_af_dataRetentionStrategy)strategy {
    switch (strategy) {
        case mk_af_dataRetentionStrategy_currentCyclePriority:
            return @"00";
        case mk_af_dataRetentionStrategy_nextCyclePriority:
            return @"01";
    }
}

+ (NSString *)fetchReportDataMaxLengthString:(mk_af_reportDataMaxLengthType)level {
    switch (level) {
        case mk_af_reportDataMaxLengthType_level1:
            return @"00";
        case mk_af_reportDataMaxLengthType_level2:
            return @"01";
    }
}

+ (NSString *)fetchScanReportStrategyString:(mk_af_scanReportStrategy)strategy {
    switch (strategy) {
        case mk_af_scanReportStrategy_close:
            return @"00";
        case mk_af_scanReportStrategy_timingScanImmediatelyReport:
            return @"01";
        case mk_af_scanReportStrategy_periodicScanImmediatelyReport:
            return @"02";
        case mk_af_scanReportStrategy_scanAlwaysOnPeriodicReport:
            return @"03";
        case mk_af_scanReportStrategy_periodicScanPeriodicReport:
            return @"04";
        case mk_af_scanReportStrategy_scanAlwaysOnTimingReport:
            return @"05";
        case mk_af_scanReportStrategy_timingScanTimingReport:
            return @"06";
        case mk_af_scanReportStrategy_periodicScanTimingReport:
            return @"07";
    }
}

+ (NSString *)fetchScanTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList {
    if (!MKValidArray(dataList)) {
        return @"00";
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:dataList.count byteLen:1];
    NSString *resultString = len;
    for (NSInteger i = 0; i < dataList.count; i ++) {
        id <mk_af_scanTimePointProtocol>data = dataList[i];
        if (data.hour < 0 || data.hour > 23 || data.minuteGear < 0 || data.minuteGear > 5) {
            return @"";
        }
        NSInteger timeValue = 0;
        if (data.hour == 0 && data.minuteGear == 0) {
            timeValue = 144;
        }else {
            timeValue = 6 * data.hour + data.minuteGear;
        }
        NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:timeValue byteLen:1];
        resultString = [resultString stringByAppendingString:timeString];
    }
    return resultString;
}

+ (NSArray <NSDictionary *>*)parseScanTimePoint:(NSString *)content {
    if (!MKValidStr(content) || content.length < 2) {
        return @[];
    }
    if ([content isEqualToString:@"00"]) {
        return @[];
    }
    NSInteger totalByte = content.length / 2;
    NSMutableArray *tempList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalByte; i ++) {
        NSString *tempString = [content substringWithRange:NSMakeRange(i * 2, 2)];
        NSInteger tempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(0, tempString.length)];
        NSInteger hour = 0;
        NSInteger minuteGear = 0;
        if (tempValue < 144) {
            //如果是144，表示00:00
            hour = tempValue / 6;
            minuteGear = tempValue % 6;
        }
        [tempList addObject:@{
            @"hour":@(hour),
            @"minuteGear":@(minuteGear),
        }];
    }
    
    return tempList;
}

+ (NSString *)fetchDuplicateDataFilter:(mk_af_duplicateDataFilter)filter {
    switch (filter) {
        case mk_af_duplicateDataFilter_none:
            return @"00";
        case mk_af_duplicateDataFilter_mac:
            return @"01";
        case mk_af_duplicateDataFilter_macAndDataType:
            return @"02";
        case mk_af_duplicateDataFilter_macAndRawData:
            return @"03";
    }
}

+ (NSString *)fetchPHYTypeString:(mk_af_PHYMode)mode {
    switch (mode) {
        case mk_af_PHYMode_BLE4:
            return @"00";
        case mk_af_PHYMode_BLE5:
            return @"01";
        case mk_af_PHYMode_BLE4AndBLE5:
            return @"02";
        case mk_af_PHYMode_CodedBLE5:
            return @"03";
    }
}

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        index += subLen * 2;
        [dataList addObject:subContent];
    }
    return dataList;
}

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @[];
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *advNameList = [NSMutableArray array];
    for (NSInteger i = 0; i < contentData.length; i ++) {
        if (index >= contentData.length) {
            break;
        }
        NSData *lenData = [contentData subdataWithRange:NSMakeRange(index, 1)];
        NSString *lenString = [MKBLEBaseSDKAdopter hexStringFromData:lenData];
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:lenString range:NSMakeRange(0, lenString.length)];
        NSData *subData = [contentData subdataWithRange:NSMakeRange(index + 1, subLen)];
        NSString *advName = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
        if (advName) {
            [advNameList addObject:advName];
        }
        index += (subLen + 1);
    }
    return advNameList;
}

+ (NSString *)parseOtherRelationship:(NSString *)other {
    if (!MKValidStr(other)) {
        return @"0";
    }
    if ([other isEqualToString:@"00"]) {
        //A
        return @"0";
    }
    if ([other isEqualToString:@"01"]) {
        //A&B
        return @"1";
    }
    if ([other isEqualToString:@"02"]) {
        //A|B
        return @"2";
    }
    if ([other isEqualToString:@"03"]) {
        //A & B & C
        return @"3";
    }
    if ([other isEqualToString:@"04"]) {
        //(A & B) | C
        return @"4";
    }
    if ([other isEqualToString:@"05"]) {
        //A | B | C
        return @"5";
    }
    return @"0";
}

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        
        NSString *type = [subContent substringWithRange:NSMakeRange(0, 2)];
        NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(2, 2)];
        NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(4, 2)];
        NSString *data = [subContent substringFromIndex:6];
        
        NSDictionary *dataDic = @{
            @"type":type,
            @"start":start,
            @"end":end,
            @"data":(data ? data : @""),
        };
        
        index += subLen * 2;
        [dataList addObject:dataDic];
    }
    return dataList;
}

+ (NSString *)parseOtherRelationshipToCmd:(mk_af_filterByOther)relationship {
    switch (relationship) {
        case mk_af_filterByOther_A:
            return @"00";
        case mk_af_filterByOther_AB:
            return @"01";
        case mk_af_filterByOther_AOrB:
            return @"02";
        case mk_af_filterByOther_ABC:
            return @"03";
        case mk_af_filterByOther_ABOrC:
            return @"04";
        case mk_af_filterByOther_AOrBOrC:
            return @"05";
    }
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_af_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    if ([protocol.dataType isEqualToString:@"00"]) {
        protocol.minIndex = 0;
        protocol.maxIndex = 0;
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (NSString *)fetchBeaconContentString:(id <mk_af_beaconContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_beaconContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.advertising ? @"1" : @"0"),(protocol.measured ? @"1" : @"0"),(protocol.minor ? @"1" : @"0"),(protocol.major ? @"1" : @"0"),(protocol.uuid ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@",@"0000000",(protocol.response ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchUIDContentString:(id <mk_af_uidContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_uidContentProtocol)]) {
        return @"";
    }
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.instanceID ? @"1" : @"0"),(protocol.namespaceID ? @"1" : @"0"),(protocol.measured ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    return [MKBLEBaseSDKAdopter getHexByBinary:binary];
}

+ (NSString *)fetchURLContentString:(id <mk_af_urlContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_urlContentProtocol)]) {
        return @"";
    }
    NSString *binary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"0",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.url ? @"1" : @"0"),(protocol.measured ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    return [MKBLEBaseSDKAdopter getHexByBinary:binary];
}

+ (NSString *)fetchTLMContentString:(id <mk_af_tlmContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_tlmContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.SEC_CNT ? @"1" : @"0"),(protocol.ADV_CNT ? @"1" : @"0"),(protocol.temperature ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.version ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@",@"000000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPBeaconContentString:(id <mk_af_bxpBeaconContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpBeaconContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.txPower ? @"1" : @"0"),(protocol.measured ? @"1" : @"0"),(protocol.minor ? @"1" : @"0"),(protocol.major ? @"1" : @"0"),(protocol.uuid ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@",@"00000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPDeviceInfoContentString:(id <mk_af_bxpDeviceInfoContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpDeviceInfoContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.deviceProperty ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0"),(protocol.firmwareVersion ? @"1" : @"0"),(protocol.switchStatus ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPACCContentString:(id <mk_af_bxpACCContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpACCContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.sampleRate ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionThreshold ? @"1" : @"0"),(protocol.fullScale ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPTHContentString:(id <mk_af_bxpTHContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpTHContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.temperature ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.advInterval ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.txPower ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@",@"00000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.humidity ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPButtonContentString:(id <mk_af_bxpButtonContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpButtonContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.firmwareType ? @"1" : @"0"),(protocol.deviceID ? @"1" : @"0"),(protocol.triggerCount ? @"1" : @"0"),(protocol.statusFlag ? @"1" : @"0"),(protocol.frameType ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *centerString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.txPower ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.rangingData ? @"1" : @"0"),(protocol.temperature ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionThreshold ? @"1" : @"0"),(protocol.fullScale ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@",@"000000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexCenter = [MKBLEBaseSDKAdopter getHexByBinary:centerString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [NSString stringWithFormat:@"%@%@%@",hexHigh,hexCenter,hexLow];
}

+ (NSString *)fetchBXPTagContentString:(id <mk_af_bxpTagContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpTagContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.battery ? @"1" : @"0"),(protocol.axisData ? @"1" : @"0"),(protocol.motionCount ? @"1" : @"0"),(protocol.hallCount ? @"1" : @"0"),(protocol.sensorStatus ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0"),(protocol.tagID ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPTofContentString:(id <mk_af_bxpTofContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpTofContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.user ? @"1" : @"0"),(protocol.ranging ? @"1" : @"0"),(protocol.battery ? @"1" : @"0"),(protocol.beacon ? @"1" : @"0"),(protocol.mfg ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@%@",@"0000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0"),(protocol.subType ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchBXPPirContentString:(id <mk_af_bxpPirContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_bxpPirContentProtocol)]) {
        return @"";
    }
    NSString *lowString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",(protocol.battery ? @"1" : @"0"),(protocol.sensorDetection ? @"1" : @"0"),(protocol.sensorSensitivity ? @"1" : @"0"),(protocol.doorStatus ? @"1" : @"0"),(protocol.pirDelayResponse ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    NSString *highString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"00",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.deviceName ? @"1" : @"0"),(protocol.rssi1m ? @"1" : @"0"),(protocol.minor ? @"1" : @"0"),(protocol.major ? @"1" : @"0")];
    NSString *hexLow = [MKBLEBaseSDKAdopter getHexByBinary:lowString];
    NSString *hexHigh = [MKBLEBaseSDKAdopter getHexByBinary:highString];
    return [hexHigh stringByAppendingString:hexLow];
}

+ (NSString *)fetchOtherTypeContentString:(id <mk_af_baseContentProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_baseContentProtocol)]) {
        return @"";
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@%@%@%@%",@"000",(protocol.response ? @"1" : @"0"),(protocol.advertising ? @"1" : @"0"),(protocol.timestamp ? @"1" : @"0"),(protocol.rssi ? @"1" : @"0"),(protocol.macAddress ? @"1" : @"0")];
    return [MKBLEBaseSDKAdopter getHexByBinary:string];
}

+ (BOOL)isConfirmOtherBlockProtocol:(id <mk_af_otherTypeBlockDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_af_otherTypeBlockDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    
    if (protocol.minIndex < 1 || protocol.minIndex > 29 || protocol.maxIndex < 1 || protocol.maxIndex > 29) {
        return NO;
    }
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    
    return YES;
}

+ (NSArray *)parseOtherBlockOptionList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 6) {
        return @[];
    }
    NSInteger totalNumber = (content.length / 6);
    if (content.length % 6 != 0) {
        totalNumber ++;
    }
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < totalNumber; i ++) {
        
        NSString *subContent = [content substringWithRange:NSMakeRange(i * 6, 6)];
        
        NSString *type = [subContent substringWithRange:NSMakeRange(0, 2)];
        NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(2, 2)];
        NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(4, 2)];
        
        NSDictionary *dataDic = @{
            @"type":type,
            @"start":start,
            @"end":end,
        };
        
        [dataList addObject:dataDic];
    }
    return dataList;
}

@end

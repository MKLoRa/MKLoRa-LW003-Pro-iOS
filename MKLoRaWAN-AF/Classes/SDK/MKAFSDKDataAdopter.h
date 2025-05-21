//
//  MKAFSDKDataAdopter.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKAFSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAFSDKDataAdopter : NSObject

+ (NSString *)fetchRepoweredDefaultModeString:(mk_af_repoweredDefaultMode)mode;

+ (NSString *)fetchLowPowerPromptString:(mk_af_lowPowerPrompt)prompt;

+ (NSString *)lorawanRegionString:(mk_af_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_af_txPower)txPower;

/// 实际值转换为0dBm、4dBm等
/// @param content content
+ (NSString *)fetchTxPowerValueString:(NSString *)content;

+ (NSString *)fetchMessageTypeString:(mk_af_messageType)messageType;

+ (NSString *)fetchDataRetentionStrategyString:(mk_af_dataRetentionStrategy)strategy;

+ (NSString *)fetchReportDataMaxLengthString:(mk_af_reportDataMaxLengthType)level;

+ (NSString *)fetchScanReportStrategyString:(mk_af_scanReportStrategy)strategy;

+ (NSArray <NSDictionary *>*)parseScanTimePoint:(NSString *)content;

+ (NSString *)fetchScanTimePoint:(NSArray <mk_af_scanTimePointProtocol>*)dataList;

+ (NSString *)fetchDuplicateDataFilter:(mk_af_duplicateDataFilter)filter;

+ (NSString *)fetchPHYTypeString:(mk_af_PHYMode)mode;

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content;

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList;

+ (NSString *)parseOtherRelationship:(NSString *)other;

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content;

+ (NSString *)parseOtherRelationshipToCmd:(mk_af_filterByOther)relationship;

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_af_BLEFilterRawDataProtocol>)protocol;

+ (NSString *)fetchBeaconContentString:(id <mk_af_beaconContentProtocol>)protocol;

+ (NSString *)fetchUIDContentString:(id <mk_af_uidContentProtocol>)protocol;

+ (NSString *)fetchURLContentString:(id <mk_af_urlContentProtocol>)protocol;

+ (NSString *)fetchTLMContentString:(id <mk_af_tlmContentProtocol>)protocol;

+ (NSString *)fetchBXPBeaconContentString:(id <mk_af_bxpBeaconContentProtocol>)protocol;

+ (NSString *)fetchBXPDeviceInfoContentString:(id <mk_af_bxpDeviceInfoContentProtocol>)protocol;

+ (NSString *)fetchBXPACCContentString:(id <mk_af_bxpACCContentProtocol>)protocol;

+ (NSString *)fetchBXPTHContentString:(id <mk_af_bxpTHContentProtocol>)protocol;

+ (NSString *)fetchBXPButtonContentString:(id <mk_af_bxpButtonContentProtocol>)protocol;

+ (NSString *)fetchBXPTagContentString:(id <mk_af_bxpTagContentProtocol>)protocol;

+ (NSString *)fetchBXPTofContentString:(id <mk_af_bxpTofContentProtocol>)protocol;

+ (NSString *)fetchBXPPirContentString:(id <mk_af_bxpPirContentProtocol>)protocol;

+ (NSString *)fetchOtherTypeContentString:(id <mk_af_baseContentProtocol>)protocol;

+ (BOOL)isConfirmOtherBlockProtocol:(id <mk_af_otherTypeBlockDataProtocol>)protocol;

+ (NSArray *)parseOtherBlockOptionList:(NSString *)content;

@end

NS_ASSUME_NONNULL_END

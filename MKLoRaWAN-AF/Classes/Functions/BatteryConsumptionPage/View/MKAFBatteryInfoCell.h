//
//  MKAFBatteryInfoCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFBatteryInfoCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *scanTime;

@property (nonatomic, copy)NSString *redIndicateTotalTime;

@property (nonatomic, copy)NSString *greenIndicateTotalTime;

@property (nonatomic, copy)NSString *blueIndicateTotalTime;

@property (nonatomic, copy)NSString *axisSleepTimes;

@property (nonatomic, copy)NSString *axisWakeupTimes;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *batteryPower;

@end

@interface MKAFBatteryInfoCell : MKBaseCell

@property (nonatomic, strong)MKAFBatteryInfoCellModel *dataModel;

+ (MKAFBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

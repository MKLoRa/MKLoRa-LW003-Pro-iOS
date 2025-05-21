//
//  MKADSelftestVoltageThresholdCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/4/27.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFSelftestVoltageThresholdCellModel : NSObject

/// 当前cell所在的index
@property (nonatomic, assign)NSInteger index;

/// 左侧显示的msg
@property (nonatomic, copy)NSString *msg;

/// 0~20
@property (nonatomic, assign)NSInteger threshold;

@end

@protocol MKAFSelftestVoltageThresholdCellDelegate <NSObject>

- (void)af_selftestVoltageThresholdCell_thresholdChanged:(NSInteger)index threshold:(NSInteger)threshold;

@end

@interface MKAFSelftestVoltageThresholdCell : MKBaseCell

@property (nonatomic, strong)MKAFSelftestVoltageThresholdCellModel *dataModel;

@property (nonatomic, weak)id <MKAFSelftestVoltageThresholdCellDelegate>delegate;

+ (MKAFSelftestVoltageThresholdCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

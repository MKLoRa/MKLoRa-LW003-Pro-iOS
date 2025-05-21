//
//  MKAFFilterBeaconCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKAFFilterBeaconCellDelegate <NSObject>

- (void)mk_af_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_af_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKAFFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKAFFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKAFFilterBeaconCellDelegate>delegate;

+ (MKAFFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

//
//  MKAFTimingModeAddCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFTimingModeAddCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKAFTimingModeAddCellDelegate <NSObject>

- (void)af_addButtonPressed:(NSInteger)index;

@end

@interface MKAFTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKAFTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKAFTimingModeAddCellDelegate>delegate;

+ (MKAFTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

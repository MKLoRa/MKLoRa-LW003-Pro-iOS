//
//  MKAFScanPageCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKAFScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)af_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKAFScanPageModel;
@interface MKAFScanPageCell : MKBaseCell

@property (nonatomic, strong)MKAFScanPageModel *dataModel;

@property (nonatomic, weak)id <MKAFScanPageCellDelegate>delegate;

+ (MKAFScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

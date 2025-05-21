//
//  MKAFReportTimePointCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFReportTimePointCellModel : NSObject

/// 当前cell所处功能号
@property (nonatomic, assign)NSInteger type;

/// 当前cell在type中的index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger hourIndex;

@property (nonatomic, assign)NSInteger timeSpaceIndex;

@end

@protocol MKAFReportTimePointCellDelegate <NSObject>

/// 删除操作
/// @param type type
/// @param index index
- (void)af_cellDeleteButtonPressed:(NSInteger)type index:(NSInteger)index;

/// 用户选择了hour事件
- (void)af_hourButtonPressed:(NSInteger)type index:(NSInteger)index;

/// 用户选择了时间间隔事件
- (void)af_timeSpaceButtonPressed:(NSInteger)type index:(NSInteger)index;

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)af_cellResetFrame;

/// cell的点击事件，用来重置cell的布局
- (void)af_cellTapAction;

@end

@interface MKAFReportTimePointCell : MKBaseCell

@property (nonatomic, weak)id <MKAFReportTimePointCellDelegate>delegate;

@property (nonatomic, strong)MKAFReportTimePointCellModel *dataModel;

+ (MKAFReportTimePointCell *)initCellWithTableView:(UITableView *)tableView;

- (BOOL)canReset;
- (void)resetCellFrame;
- (void)resetFlagForFrame;

@end

NS_ASSUME_NONNULL_END

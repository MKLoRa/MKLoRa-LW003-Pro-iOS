//
//  MKAFFilterEditSectionHeaderView.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKAFFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_af_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_af_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKAFFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKAFFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKAFFilterEditSectionHeaderViewDelegate>delegate;

+ (MKAFFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

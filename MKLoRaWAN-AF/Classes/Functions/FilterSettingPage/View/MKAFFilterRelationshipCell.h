//
//  MKAFFilterRelationshipCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/3/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFFilterRelationshipCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray *dataList;

@end

@protocol MKAFFilterRelationshipCellDelegate <NSObject>

- (void)af_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKAFFilterRelationshipCell : MKBaseCell

@property (nonatomic, strong)MKAFFilterRelationshipCellModel *dataModel;

@property (nonatomic, weak)id <MKAFFilterRelationshipCellDelegate>delegate;

+ (MKAFFilterRelationshipCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

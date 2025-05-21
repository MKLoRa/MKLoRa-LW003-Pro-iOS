//
//  MKAFOtherTypeContentCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFOtherTypeContentCellModel : NSObject

/// 当前cell所处Block号
@property (nonatomic, assign)NSInteger blockNumber;

/// 当前cell在blockNumber中的index
@property (nonatomic, assign)NSInteger blockIndex;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *dataType;

@property (nonatomic, copy)NSString *startIndex;

@property (nonatomic, copy)NSString *endIndex;

@property (nonatomic, copy)NSString *unitMsg;

@end

@protocol MKAFOtherTypeContentCellDelegate <NSObject>

- (void)af_otherCellDeletedWithNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex;

- (void)af_otherCellDataTypeChanged:(NSString *)dataType
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex;

- (void)af_otherCellStartIndexChanged:(NSString *)startIndex
                          blockNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex;

- (void)af_otherCellEndIndexChanged:(NSString *)endIndex
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex;

@end

@interface MKAFOtherTypeContentCell : MKBaseCell

@property (nonatomic, weak)id <MKAFOtherTypeContentCellDelegate>delegate;

@property (nonatomic, strong)MKAFOtherTypeContentCellModel *dataModel;

+ (MKAFOtherTypeContentCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

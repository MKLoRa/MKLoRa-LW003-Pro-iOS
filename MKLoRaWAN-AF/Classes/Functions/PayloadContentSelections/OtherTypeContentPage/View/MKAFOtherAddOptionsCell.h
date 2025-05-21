//
//  MKAFOtherAddOptionsCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/11/2.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFOtherAddOptionsCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKAFOtherAddOptionsCellDelegate <NSObject>

- (void)af_otherAddOptionsCellAddPressed:(NSInteger)index;

@end

@interface MKAFOtherAddOptionsCell : MKBaseCell

@property (nonatomic, weak)id <MKAFOtherAddOptionsCellDelegate>delegate;

@property (nonatomic, strong)MKAFOtherAddOptionsCellModel *dataModel;

+ (MKAFOtherAddOptionsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

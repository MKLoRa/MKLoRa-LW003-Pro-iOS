//
//  MKAFDebuggerCell.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKAFDebuggerCellDelegate <NSObject>

- (void)af_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKAFDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKAFDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKAFDebuggerCellDelegate>delegate;

+ (MKAFDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

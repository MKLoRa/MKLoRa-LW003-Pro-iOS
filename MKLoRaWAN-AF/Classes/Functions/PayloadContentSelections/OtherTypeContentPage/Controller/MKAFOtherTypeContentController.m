//
//  MKAFOtherTypeContentController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFOtherTypeContentController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKAFOtherAddOptionsCell.h"
#import "MKAFOtherTypeContentCell.h"

#import "MKAFOtherTypeContentModel.h"

@interface MKAFOtherTypeContentController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKAFOtherAddOptionsCellDelegate,
MKAFOtherTypeContentCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFOtherTypeContentModel *dataModel;

@end

@implementation MKAFOtherTypeContentController

- (void)dealloc {
    NSLog(@"MKAFOtherTypeContentController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 0.f;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKAFOtherAddOptionsCell *cell = [MKAFOtherAddOptionsCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKAFOtherTypeContentCell *cell = [MKAFOtherTypeContentCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section3List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //MAC Address
        self.dataModel.macAddress = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 1) {
        //RSSI
        self.dataModel.rssi = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[1];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 2) {
        //Timestamp
        self.dataModel.timestamp = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[2];
        cellModel.isOn = isOn;
        return;
    }
    
    if (index == 3) {
        //Raw data - Advertising
        self.dataModel.advertising = isOn;
        MKTextSwitchCellModel *cellModel = self.section3List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 4) {
        //Raw data - Response
        self.dataModel.response = isOn;
        MKTextSwitchCellModel *cellModel = self.section3List[1];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKAFOtherAddOptionsCellDelegate
- (void)af_otherAddOptionsCellAddPressed:(NSInteger)index {
    if (self.section2List.count >= 10) {
        [self.view showCentralToast:@"You can set up to 10 data blocks!"];
        return;
    }
    MKAFOtherTypeContentCellModel *cellModel = [[MKAFOtherTypeContentCellModel alloc] init];
    cellModel.blockNumber = 0;
    cellModel.blockIndex = self.section2List.count;
    cellModel.msg = [NSString stringWithFormat:@"Data block %ld",(long)(self.section2List.count + 1)];
    cellModel.unitMsg = @"Byte";
    [self.section2List addObject:cellModel];
    [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - MKAFOtherTypeContentCellDelegate
- (void)af_otherCellDeletedWithNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex {
    if (blockNumber != 0) {
        return;
    }
    if (self.section2List.count == 0 || blockIndex >= self.section2List.count) {
        return;
    }
    [self.section2List removeObjectAtIndex:blockIndex];
    
    for (NSInteger i = 0; i < self.section2List.count; i ++) {
        MKAFOtherTypeContentCellModel *cellModel = self.section2List[i];
        cellModel.blockIndex = i;
        cellModel.msg = [NSString stringWithFormat:@"Data block %d",(long)(i + 1)];
    }
    
    [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)af_otherCellDataTypeChanged:(NSString *)dataType
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex {
    if (blockNumber != 0) {
        return;
    }
    if (self.section2List.count == 0 || blockIndex >= self.section2List.count) {
        return;
    }
    MKAFOtherTypeContentCellModel *cellModel = self.section2List[blockIndex];
    cellModel.dataType = dataType;
}

- (void)af_otherCellStartIndexChanged:(NSString *)startIndex
                          blockNumber:(NSInteger)blockNumber
                           blockIndex:(NSInteger)blockIndex {
    if (blockNumber != 0) {
        return;
    }
    if (self.section2List.count == 0 || blockIndex >= self.section2List.count) {
        return;
    }
    MKAFOtherTypeContentCellModel *cellModel = self.section2List[blockIndex];
    cellModel.startIndex = startIndex;
}

- (void)af_otherCellEndIndexChanged:(NSString *)endIndex
                        blockNumber:(NSInteger)blockNumber
                         blockIndex:(NSInteger)blockIndex {
    if (blockNumber != 0) {
        return;
    }
    if (self.section2List.count == 0 || blockIndex >= self.section2List.count) {
        return;
    }
    MKAFOtherTypeContentCellModel *cellModel = self.section2List[blockIndex];
    cellModel.endIndex = endIndex;
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    NSMutableArray *optionList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section2List.count; i ++) {
        MKAFOtherTypeContentCellModel *cellModel = self.section2List[i];
        if (!ValidStr(cellModel.startIndex) || !ValidStr(cellModel.endIndex)) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:[NSString stringWithFormat:@"Data block %@ Params Error",@(i + 1)]];
            return;
        }
        MKAFOtherBlockOptionModel *optionModel = [[MKAFOtherBlockOptionModel alloc] init];
        optionModel.dataType = cellModel.dataType;
        optionModel.minIndex = [cellModel.startIndex integerValue];
        optionModel.maxIndex = [cellModel.endIndex integerValue];
        if (![optionModel validParams]) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:[NSString stringWithFormat:@"Data block %@ Params Error",@(i + 1)]];
            return;
        }
        [optionList addObject:optionModel];
    }
    [self.dataModel configBlockOptionList:optionList sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    
    for (NSInteger i = 0; i < 4; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"MAC Address";
    cellModel1.isOn = self.dataModel.macAddress;
    [self.section0List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"RSSI";
    cellModel2.isOn = self.dataModel.rssi;
    [self.section0List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Timestamp";
    cellModel3.isOn = self.dataModel.timestamp;
    [self.section0List addObject:cellModel3];
}

- (void)loadSection1Datas {
    MKAFOtherAddOptionsCellModel *cellModel = [[MKAFOtherAddOptionsCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Data block Options";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    for (NSInteger i = 0; i < self.dataModel.blockList.count; i ++) {
        MKAFOtherBlockOptionModel *model = self.dataModel.blockList[i];
        MKAFOtherTypeContentCellModel *cellModel = [[MKAFOtherTypeContentCellModel alloc] init];
        cellModel.blockNumber = 0;
        cellModel.blockIndex = i;
        cellModel.msg = [NSString stringWithFormat:@"Data block %d",(long)(i + 1)];
        cellModel.dataType = model.dataType;
        cellModel.startIndex = [NSString stringWithFormat:@"%ld",(long)model.minIndex];
        cellModel.endIndex = [NSString stringWithFormat:@"%ld",(long)model.maxIndex];
        cellModel.unitMsg = @"Byte";
        [self.section2List addObject:cellModel];
    }
}

- (void)loadSection3Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 3;
    cellModel1.msg = @"Raw data - Advertising";
    cellModel1.isOn = self.dataModel.advertising;
    [self.section3List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 4;
    cellModel2.msg = @"Raw data - Response";
    cellModel2.isOn = self.dataModel.response;
    [self.section3List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Other Type Content";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFOtherTypeContentController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFOtherTypeContentModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFOtherTypeContentModel alloc] init];
    }
    return _dataModel;
}

@end

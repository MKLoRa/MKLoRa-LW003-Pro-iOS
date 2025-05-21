//
//  MKAFAlarmPayloadSettingsController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2025/5/16.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKAFAlarmPayloadSettingsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextButtonCell.h"
#import "MKTextFieldCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKAFAlarmPayloadSettingsModel.h"

@interface MKAFAlarmPayloadSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFAlarmPayloadSettingsModel *dataModel;

@end

@implementation MKAFAlarmPayloadSettingsController

- (void)dealloc {
    NSLog(@"MKAFAlarmPayloadSettingsController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextButtonCellModel *cellModel = self.section0List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 1) {
        MKTextFieldCellModel *cellModel = self.section1List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *header = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    header.headerModel = self.headerList[section];
    return header;
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
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //Duplicate Alarm Data Filter
        self.dataModel.filter = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Alarm Data Filter Period
        self.dataModel.period = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
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
    [self.dataModel configDataWithSucBlock:^{
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
    
    for (NSInteger i = 0; i < 2; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Duplicate Data Filter";
    cellModel.dataList = @[@"No",@"MAC",@"MAC+Data Type",@"MAC+Raw Data"];
    cellModel.dataListIndex = self.dataModel.filter;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Alarm Data Filter Period";
    cellModel.msgFont = MKFont(13.f);
    cellModel.textFieldValue = self.dataModel.period;
    cellModel.textPlaceholder = @"1 ~ 5";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.maxLength = 1;
    cellModel.unit = @"s";
    [self.section1List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Alarm Payload Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFAlarmPayloadSettingsController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-49.f);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFAlarmPayloadSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFAlarmPayloadSettingsModel alloc] init];
    }
    return _dataModel;
}

@end

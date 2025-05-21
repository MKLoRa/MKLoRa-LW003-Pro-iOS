//
//  MKAFFilterSettingController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFFilterSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKNormalSliderCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKCustomUIAdopter.h"

#import "MKFilterByMacController.h"
#import "MKFilterByAdvNameController.h"

#import "MKAFFilterRelationshipCell.h"

#import "MKAFFilterSettingModel.h"
#import "MKAFFilterByMacModel.h"
#import "MKAFFilterByAdvNameModel.h"

#import "MKAFFilterByRawDataController.h"

@interface MKAFFilterSettingController ()<UITableViewDelegate,
UITableViewDataSource,
MKNormalSliderCellDelegate,
MKAFFilterRelationshipCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFFilterSettingModel *dataModel;

@end

@implementation MKAFFilterSettingController

- (void)dealloc {
    NSLog(@"MKAFFilterSettingController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    //本页面禁止右划退出手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.f;
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        //Filter by MAC
        MKFilterByMacController *vc = [[MKFilterByMacController alloc] init];
        MKAFFilterByMacModel *model = [[MKAFFilterByMacModel alloc] init];
        model.pageTitle = @"Filter by MAC";
        vc.protocol = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        //Filter by ADV Name
        MKFilterByAdvNameController *vc = [[MKFilterByAdvNameController alloc] init];
        MKAFFilterByAdvNameModel *model = [[MKAFFilterByAdvNameModel alloc] init];
        model.pageTitle = @"Filter by ADV Name";
        vc.protocol = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        //Filter by Raw Data
        MKAFFilterByRawDataController *vc = [[MKAFFilterByRawDataController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
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
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalSliderCell *cell = [MKNormalSliderCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKAFFilterRelationshipCell *cell = [MKAFFilterRelationshipCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - MKNormalSliderCellDelegate
/// slider值发生改变的回调事件
/// @param value 当前slider的值
/// @param index 当前cell所在的index
- (void)mk_normalSliderValueChanged:(NSInteger)value index:(NSInteger)index {
    if (index == 0) {
        //RSSI Filter
        self.dataModel.rssi = value;
        MKNormalSliderCellModel *cellModel = self.section0List[0];
        cellModel.sliderValue = value;
        return;
    }
}

#pragma mark - MKAFFilterRelationshipCellDelegate
- (void)af_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex {
    if (index == 0) {
        //Scanning Type/PHY
        self.dataModel.phy = dataListIndex;
        MKAFFilterRelationshipCellModel *cellModel = self.section1List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 1) {
        //Filter Relationship
        self.dataModel.relationship = dataListIndex;
        MKAFFilterRelationshipCellModel *cellModel = self.section1List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
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
    [self loadSection2Datas];
    
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalSliderCellModel *cellModel = [[MKNormalSliderCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = [MKCustomUIAdopter attributedString:@[@"RSSI Filter",@"   (-127dBm ~ 0dBm)"] fonts:@[MKFont(15.f),MKFont(13.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(223, 223, 223)]];
    cellModel.changed = YES;
    cellModel.noteMsgColor = RGBCOLOR(223, 223, 223);
    cellModel.leftNoteMsg = @"*The device will uplink valid ADV data with RSSI no less than";
    cellModel.rightNoteMsg = @".";
    cellModel.sliderValue = self.dataModel.rssi;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKAFFilterRelationshipCellModel *cellModel1 = [[MKAFFilterRelationshipCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Scanning Type/PHY";
    cellModel1.dataList = @[@"1M PHY (BLE 4.x)",@"1M PHY (BLE 5)",@"1M PHY(BLE4.x+BLE5)",
                            @"Coded PHY(BLE 5)"];
    cellModel1.dataListIndex = self.dataModel.phy;
    [self.section1List addObject:cellModel1];
    
    MKAFFilterRelationshipCellModel *cellModel2 = [[MKAFFilterRelationshipCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Filter Relationship";
    cellModel2.dataList = @[@"Null",@"Only MAC",@"Only ADV Name",@"Only Raw Data",@"ADV Name & Raw Data",@"MAC & ADV Name & Raw Data",@"ADV Name | Raw Data"];
    cellModel2.dataListIndex = self.dataModel.relationship;
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Filter by MAC";
    cellModel1.showRightIcon = YES;
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Filter by ADV Name";
    cellModel2.showRightIcon = YES;
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Filter by Raw Data";
    cellModel3.showRightIcon = YES;
    [self.section2List addObject:cellModel3];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Bluetooth Filter Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFFilterSettingController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFFilterSettingModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFFilterSettingModel alloc] init];
    }
    return _dataModel;
}

@end

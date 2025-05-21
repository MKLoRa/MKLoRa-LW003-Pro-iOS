//
//  MKAFTimingReportController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFTimingReportController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKPickerView.h"
#import "MKTableSectionLineHeader.h"

#import "MKAFScanTimePointModel.h"

#import "MKAFTimingReportModel.h"

#import "MKAFReportTimePointCell.h"
#import "MKAFTimingModeAddCell.h"

@interface MKAFTimingReportController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKAFTimingModeAddCellDelegate,
MKAFReportTimePointCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFTimingReportModel *dataModel;

@end

@implementation MKAFTimingReportController

- (void)dealloc {
    NSLog(@"MKAFTimingReportController销毁");
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
        return 44.f;
    }
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 3) {
        return 10.f;
    }
    return 0.f;
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
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 1) {
        MKAFTimingModeAddCell *cell = [MKAFTimingModeAddCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKAFReportTimePointCell *cell = [MKAFReportTimePointCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        [cell resetFlagForFrame];
        return cell;
    }
    if (indexPath.section == 3) {
        MKAFTimingModeAddCell *cell = [MKAFTimingModeAddCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKAFReportTimePointCell *cell = [MKAFReportTimePointCell initCellWithTableView:tableView];
    cell.dataModel = self.section4List[indexPath.row];
    cell.delegate = self;
    [cell resetFlagForFrame];
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Bluetooth Scan Duration
        self.dataModel.duration = value;
        MKTextFieldCellModel *cellModel = self.section0List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKAFTimingModeAddCellDelegate
- (void)af_addButtonPressed:(NSInteger)index {
    if (index == 0) {
        //Bluetooth Scan Time Point
        if (self.section2List.count >= 48) {
            //最多10组
            [self.view showCentralToast:@"You can set up to 48 time points!"];
            return;
        }
        MKAFReportTimePointCellModel *cellModel = [[MKAFReportTimePointCellModel alloc] init];
        cellModel.type = 0;
        cellModel.index = self.section2List.count;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(self.section2List.count + 1)];
        cellModel.hourIndex = 0;
        cellModel.timeSpaceIndex = 0;
        [self.section2List addObject:cellModel];
        
        [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 1) {
        //Report Time Point
        if (self.section4List.count >= 24) {
            //最多10组
            [self.view showCentralToast:@"You can set up to 24 time points!"];
            return;
        }
        MKAFReportTimePointCellModel *cellModel = [[MKAFReportTimePointCellModel alloc] init];
        cellModel.type = 1;
        cellModel.index = self.section4List.count;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(self.section4List.count + 1)];
        cellModel.hourIndex = 0;
        cellModel.timeSpaceIndex = 0;
        [self.section4List addObject:cellModel];
        
        [self.tableView mk_reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

#pragma mark - MKAFReportTimePointCellDelegate

- (void)af_cellDeleteButtonPressed:(NSInteger)type index:(NSInteger)index {
    if (type == 0) {
        //Bluetooth Scan Time Point
        if (index > self.section2List.count - 1) {
            return;
        }
        [self.section2List removeObjectAtIndex:index];
        
        for (NSInteger i = 0; i < self.section2List.count; i ++) {
            MKAFReportTimePointCellModel *cellModel = self.section2List[i];
            cellModel.index = i;
            cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
        }
        
        [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (type == 1) {
        //Report Time Point
        if (index > self.section4List.count - 1) {
            return;
        }
        [self.section4List removeObjectAtIndex:index];
        
        for (NSInteger i = 0; i < self.section4List.count; i ++) {
            MKAFReportTimePointCellModel *cellModel = self.section4List[i];
            cellModel.index = i;
            cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
        }
        
        [self.tableView mk_reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
}

/// 用户选择了hour事件
- (void)af_hourButtonPressed:(NSInteger)type index:(NSInteger)index {
    
    if (![self cellCanSelected]) {
        return;
    }
    [self showTimePointHourPickView:type index:index];
}

/// 用户选择了时间间隔事件
- (void)af_timeSpaceButtonPressed:(NSInteger)type index:(NSInteger)index {
    if (![self cellCanSelected]) {
        return;
    }
    [self showTimePointTimeSpacePickView:type index:index];
}

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)af_cellResetFrame {
    [self cellCanSelected];
}

- (void)af_cellTapAction {
    [self cellCanSelected];
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
    NSMutableArray *scanList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section2List.count; i ++) {
        MKAFReportTimePointCellModel *cellModel = self.section2List[i];
        MKAFScanTimePointModel *pointModel = [[MKAFScanTimePointModel alloc] init];
        pointModel.hour = cellModel.hourIndex;
        pointModel.minuteGear = cellModel.timeSpaceIndex;
        [scanList addObject:pointModel];
    }
    NSMutableArray *reportList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.section4List.count; i ++) {
        MKAFReportTimePointCellModel *cellModel = self.section4List[i];
        MKAFScanTimePointModel *pointModel = [[MKAFScanTimePointModel alloc] init];
        pointModel.hour = cellModel.hourIndex;
        pointModel.minuteGear = cellModel.timeSpaceIndex;
        [reportList addObject:pointModel];
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configScanPointList:scanList reportPointList:reportList sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method
/**
 当有cell右侧的删除按钮出现时，不能触发点击事件
 
 @return YES可点击，NO不可点击
 */
- (BOOL)cellCanSelected{
    BOOL canSelected = YES;
    NSArray *arrCells = [self.tableView visibleCells];
    for (int i = 0; i < [arrCells count]; i++) {
        UITableViewCell *cell = arrCells[i];
        if ([cell isKindOfClass:MKAFReportTimePointCell.class]) {
            MKAFReportTimePointCell *tempCell = (MKAFReportTimePointCell *)cell;
            if ([tempCell canReset]) {
                [tempCell resetCellFrame];
                canSelected = NO;
            }
        }
    }
    return canSelected;
}

- (void)showTimePointHourPickView:(NSInteger)type index:(NSInteger)index {
    
    MKAFReportTimePointCellModel *cellModel = (type == 0 ? self.section2List[index] : self.section4List[index]);
    
    MKPickerView *pickView = [[MKPickerView alloc] init];
    NSArray *dataList = @[@"00",@"01",@"02",@"03",
                          @"04",@"05",@"06",@"07",
                          @"08",@"09",@"10",@"11",
                          @"12",@"13",@"14",@"15",
                          @"16",@"17",@"18",@"19",
                          @"20",@"21",@"22",@"23"];
    [pickView showPickViewWithDataList:dataList selectedRow:cellModel.hourIndex block:^(NSInteger currentRow) {
        cellModel.hourIndex = currentRow;
        [self.tableView mk_reloadRow:index inSection:(type == 0 ? 2 : 4) withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)showTimePointTimeSpacePickView:(NSInteger)type index:(NSInteger)index {
    MKAFReportTimePointCellModel *cellModel = (type == 0 ? self.section2List[index] : self.section4List[index]);
    
    MKPickerView *pickView = [[MKPickerView alloc] init];
    NSArray *dataList = @[@"00",@"10",@"20",@"30",@"40",@"50"];
    [pickView showPickViewWithDataList:dataList selectedRow:cellModel.timeSpaceIndex block:^(NSInteger currentRow) {
        cellModel.timeSpaceIndex = currentRow;
        [self.tableView mk_reloadRow:index inSection:(type == 0 ? 2 : 4) withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    
    for (NSInteger i = 0; i < 5; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Bluetooth Scan Duration";
    cellModel.msgFont = MKFont(13.f);
    cellModel.textPlaceholder = @"3 ~ 65535";
    cellModel.maxLength = 5;
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.textFieldValue = self.dataModel.duration;
    cellModel.unit = @"s";
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKAFTimingModeAddCellModel * cellModel = [[MKAFTimingModeAddCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Bluetooth Scan Time Point";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    for (NSInteger i = 0; i < self.dataModel.scanPointList.count; i ++) {
        MKAFScanTimePointModel *tempModel = self.dataModel.scanPointList[i];
        MKAFReportTimePointCellModel *cellModel = [[MKAFReportTimePointCellModel alloc] init];
        cellModel.type = 0;
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
        cellModel.hourIndex = tempModel.hour;
        cellModel.timeSpaceIndex = tempModel.minuteGear;
        [self.section2List addObject:cellModel];
    }
}

- (void)loadSection3Datas {
    MKAFTimingModeAddCellModel * cellModel = [[MKAFTimingModeAddCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Report Time Point";
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    for (NSInteger i = 0; i < self.dataModel.reportPointList.count; i ++) {
        MKAFScanTimePointModel *tempModel = self.dataModel.reportPointList[i];
        MKAFReportTimePointCellModel *cellModel = [[MKAFReportTimePointCellModel alloc] init];
        cellModel.type = 1;
        cellModel.index = i;
        cellModel.msg = [NSString stringWithFormat:@"Time Point %ld",(long)(i + 1)];
        cellModel.hourIndex = tempModel.hour;
        cellModel.timeSpaceIndex = tempModel.minuteGear;
        [self.section4List addObject:cellModel];
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Timing Scan & Timing Report";
    self.titleLabel.font = MKFont(15.f);
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFTimingReportController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFTimingReportModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFTimingReportModel alloc] init];
    }
    return _dataModel;
}

@end

//
//  MKAFMessageTypeController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFMessageTypeController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextButtonCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKAFMessageTypeModel.h"

@interface MKAFMessageTypeController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFMessageTypeModel *dataModel;

@end

@implementation MKAFMessageTypeController

- (void)dealloc {
    NSLog(@"MKAFMessageTypeController销毁");
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
    return 50.f;
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
        return (self.dataModel.deviceInfoPayload == 1 ? self.section0List.count : 1);
    }
    if (section == 1) {
        return (self.dataModel.heartbeatPayload == 1 ? self.section1List.count : 1);
    }
    if (section == 2) {
        return (self.dataModel.lowPowerPayload == 1 ? self.section2List.count : 1);
    }
    if (section == 3) {
        return (self.dataModel.eventPayload == 1 ? self.section3List.count : 1);
    }
    if (section == 4) {
        return (self.dataModel.beaconPayload == 1 ? self.section4List.count : 1);
    }
    if (section == 5) {
        return (self.dataModel.alarmPayload == 1 ? self.section5List.count : 1);
    }
    if (section == 6) {
        return (self.dataModel.gatewayPayload == 1 ? self.section6List.count : 1);
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
    if (indexPath.section == 1) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.section6List[indexPath.row];
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
        //Device Information Payload Type
        self.dataModel.deviceInfoPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 1) {
        //Device Information/Max Retransmission Times
        self.dataModel.deviceInfoMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section0List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 2) {
        //Heartbeat Payload Type
        self.dataModel.heartbeatPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section1List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 3) {
        //Heartbeat/Max Retransmission Times
        self.dataModel.heartbeatMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section1List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 4) {
        //Low-Power Payload Type
        self.dataModel.lowPowerPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section2List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 5) {
        //Low-Power/Max Retransmission Times
        self.dataModel.lowPowerMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section2List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 6) {
        //Event Payload Type
        self.dataModel.eventPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section3List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 7) {
        //event/Max Retransmission Times
        self.dataModel.eventMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section3List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 8) {
        //Beacon Payload Type
        self.dataModel.beaconPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section4List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 9) {
        //beacon/Max Retransmission Times
        self.dataModel.beaconMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section4List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 10) {
        //Alarm Payload Type
        self.dataModel.alarmPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section5List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 11) {
        //Alarm/Max Retransmission Times
        self.dataModel.alarmMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section5List[1];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 12) {
        //Gateway Connect Payload Type
        self.dataModel.gatewayPayload = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section6List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView mk_reloadSection:6 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 13) {
        //Gateway Connect/Max Retransmission Times
        self.dataModel.gatewayMaxRetransmission = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section6List[1];
        cellModel.dataListIndex = dataListIndex;
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

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    
    for (NSInteger i = 0; i < 7; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Device Information Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.deviceInfoPayload;
    [self.section0List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.deviceInfoMaxRetransmission;
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"Heartbeat Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.heartbeatPayload;
    [self.section1List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.heartbeatMaxRetransmission;
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 4;
    cellModel1.msg = @"Low-Power Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.lowPowerPayload;
    [self.section2List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 5;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.lowPowerMaxRetransmission;
    [self.section2List addObject:cellModel2];
}

- (void)loadSection3Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 6;
    cellModel1.msg = @"Event Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.eventPayload;
    [self.section3List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 7;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.eventMaxRetransmission;
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 8;
    cellModel1.msg = @"Beacon Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.beaconPayload;
    [self.section4List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 9;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.beaconMaxRetransmission;
    [self.section4List addObject:cellModel2];
}

- (void)loadSection5Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 10;
    cellModel1.msg = @"Alarm Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.alarmPayload;
    [self.section5List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 11;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.alarmMaxRetransmission;
    [self.section5List addObject:cellModel2];
}

- (void)loadSection6Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 12;
    cellModel1.msg = @"Gateway Connect Payload Type";
    cellModel1.dataList = @[@"Unconfirmed",@"Confirmed"];
    cellModel1.dataListIndex = self.dataModel.gatewayPayload;
    [self.section6List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 13;
    cellModel2.msg = @"Max Retransmission Times";
    cellModel2.dataList = @[@"0",@"1",@"2",@"3"];
    cellModel2.dataListIndex = self.dataModel.gatewayMaxRetransmission;
    [self.section6List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Message Type Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFMessageTypeController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFMessageTypeModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFMessageTypeModel alloc] init];
    }
    return _dataModel;
}

@end

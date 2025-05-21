//
//  MKAFDeviceSettingController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFDeviceSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"
#import "MKTextFieldCell.h"
#import "MKAlertView.h"

#import "MKTableSectionLineHeader.h"

#import "MKAFInterface+MKAFConfig.h"

#import "MKAFConnectModel.h"

#import "MKAFDeviceSettingModel.h"

#import "MKAFSynDataController.h"
#import "MKAFIndicatorSettingController.h"
#import "MKAFDeviceInfoController.h"
#import "MKAFOnOffSettingsController.h"

@interface MKAFDeviceSettingController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
mk_textSwitchCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *section8List;

@property (nonatomic, strong)NSMutableArray *section9List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFDeviceSettingModel *dataModel;

@property (nonatomic, strong)UITextField *passwordTextField;

@property (nonatomic, strong)UITextField *confirmTextField;

@property (nonatomic, copy)NSString *passwordAsciiStr;

@property (nonatomic, copy)NSString *confirmAsciiStr;

@property (nonatomic, strong)NSArray *timeZoneList;

@end

@implementation MKAFDeviceSettingController

- (void)dealloc {
    NSLog(@"MKAFDeviceSettingController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    [self readDataFromDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_af_popToRootViewControllerNotification" object:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        MKTextButtonCellModel *cellModel = self.section5List[0];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4 || section == 5) {
        return 0.f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Local Data Sync
        MKAFSynDataController *vc = [[MKAFSynDataController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        //Indicator Settings
        MKAFIndicatorSettingController *vc = [[MKAFIndicatorSettingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];return;
    }
    if (indexPath.section == 7 && indexPath.row == 0) {
        //ON/OFF Settings
        MKAFOnOffSettingsController *vc = [[MKAFOnOffSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];return;
    }
    if (indexPath.section == 8 && indexPath.row == 0) {
        //Device Info
        MKAFDeviceInfoController *vc = [[MKAFDeviceInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];return;
    }
    if (indexPath.section == 9 && indexPath.row == 0) {
        //恢复出厂设置
        [self factoryReset];return;
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
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return ([[MKAFConnectModel shared].deviceType isEqualToString:@"00"] ? 0 : self.section5List.count);
    }
    if (section == 6) {
        return ([[MKAFConnectModel shared].deviceType isEqualToString:@"20"] ? self.section6List.count : 0);
    }
    if (section == 7) {
        return self.section7List.count;
    }
    if (section == 8) {
        return self.section8List.count;
    }
    if (section == 9) {
        return self.section9List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
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
    if (indexPath.section == 6) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 7) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section7List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 8) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section8List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section9List[indexPath.row];
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
        //Current Time Zone
        self.dataModel.timeZone = index;
        MKTextButtonCellModel *cellModel = self.section2List[0];
        cellModel.dataListIndex = index;return;
    }
    if (index == 1) {
        //Low Power Prompt
        self.dataModel.prompt = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section5List[0];
        cellModel.dataListIndex = dataListIndex;
        cellModel.noteMsg = [NSString stringWithFormat:@"*When the battery is less than or equal to %@, the red LED will flash once every 30 seconds.",cellModel.dataList[dataListIndex]];
        return;
    }
    if (index == 2) {
        //Charge Priority
        self.dataModel.chargePriority = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section6List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Low-power Payload
        self.dataModel.lowPowerPayload = isOn;
        MKTextSwitchCellModel *cellModel = self.section3List[0];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        self.dataModel.lowPowerReportInterval = value;
        MKTextFieldCellModel *cellModel = self.section4List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        [[MKHudManager share] hide];
        [self updateCellStates];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateCellStates {
    MKTextButtonCellModel *timeZoneModel = self.section2List[0];
    timeZoneModel.dataListIndex = self.dataModel.timeZone;
    
    MKTextSwitchCellModel *lowPowerPayloadModel = self.section3List[0];
    lowPowerPayloadModel.isOn = self.dataModel.lowPowerPayload;
    
    MKTextFieldCellModel *reportIntervalModel = self.section4List[0];
    reportIntervalModel.textFieldValue = self.dataModel.lowPowerReportInterval;
    
    MKTextButtonCellModel *promptModel = self.section5List[0];
    promptModel.dataListIndex = self.dataModel.prompt;
    promptModel.noteMsg = [NSString stringWithFormat:@"*When the battery is less than or equal to %@, the red LED will flash once every 30 seconds.",promptModel.dataList[self.dataModel.prompt]];
    
    MKTextButtonCellModel *chargeModel = self.section6List[0];
    timeZoneModel.dataListIndex = self.dataModel.chargePriority;
    
    [self.tableView reloadData];
    
    //让MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView"
                                                        object:nil
                                                      userInfo:nil];
}

#pragma mark - 恢复出厂设置

- (void)factoryReset{
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        [self sendResetCommandToDevice];
    }];
    NSString *msg = @"After factory reset,all the data will be reseted to the factory values.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Factory Reset" message:msg notificationName:@"mk_af_needDismissAlert"];
}

- (void)sendResetCommandToDevice{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKAFInterface af_factoryResetWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Factory reset successfully!Please reconnect the device."];
    } failedBlock:^(NSError * _Nonnull error) {
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
    [self loadSection7Datas];
    [self loadSection8Datas];
    [self loadSection9Datas];
    
    for (NSInteger i = 0; i < 10; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Local Data Sync";
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Indicator Settings";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Current Time Zone";
    cellModel.dataList = [NSArray arrayWithArray:self.timeZoneList];
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Low-power Payload";
    [self.section3List addObject:cellModel1];
}

- (void)loadSection4Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Low-power Report Interval";
    cellModel.maxLength = 3;
    cellModel.unit = @"x30mins";
    cellModel.textPlaceholder = @"1 ~ 255";
    cellModel.textFieldType = mk_realNumberOnly;
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Low Power Prompt";
    cellModel.dataList = @[@"10%",@"20%",@"30%",@"40%",@"50%"];
    cellModel.noteMsg = @"*When the battery is less than or equal to 10%, the red LED will flash once every 30 seconds.";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    cellModel.dataListIndex = 1;
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 2;
    cellModel.msg = @"Charge Priority";
    cellModel.dataList = @[@"DC Priority",@"Solar Priority"];
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"ON/OFF Settings";
    [self.section7List addObject:cellModel];
}

- (void)loadSection8Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Device Information";
    [self.section8List addObject:cellModel];
}

- (void)loadSection9Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Factory Reset";
    [self.section9List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device Settings";
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

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (NSMutableArray *)section8List {
    if (!_section8List) {
        _section8List = [NSMutableArray array];
    }
    return _section8List;
}

- (NSMutableArray *)section9List {
    if (!_section9List) {
        _section9List = [NSMutableArray array];
    }
    return _section9List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFDeviceSettingModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFDeviceSettingModel alloc] init];
    }
    return _dataModel;
}

- (NSArray *)timeZoneList {
    if (!_timeZoneList) {
        _timeZoneList = @[@"UTC-12:00",@"UTC-11:30",@"UTC-11:00",@"UTC-10:30",@"UTC-10:00",@"UTC-09:30",
                          @"UTC-09:00",@"UTC-08:30",@"UTC-08:00",@"UTC-07:30",@"UTC-07:00",@"UTC-06:30",
                          @"UTC-06:00",@"UTC-05:30",@"UTC-05:00",@"UTC-04:30",@"UTC-04:00",@"UTC-03:30",
                          @"UTC-03:00",@"UTC-02:30",@"UTC-02:00",@"UTC-01:30",@"UTC-01:00",@"UTC-00:30",
                          @"UTC+00:00",@"UTC+00:30",@"UTC+01:00",@"UTC+01:30",@"UTC+02:00",@"UTC+02:30",
                          @"UTC+03:00",@"UTC+03:30",@"UTC+04:00",@"UTC+04:30",@"UTC+05:00",@"UTC+05:30",
                          @"UTC+06:00",@"UTC+06:30",@"UTC+07:00",@"UTC+07:30",@"UTC+08:00",@"UTC+08:30",
                          @"UTC+09:00",@"UTC+09:30",@"UTC+10:00",@"UTC+10:30",@"UTC+11:00",@"UTC+11:30",
                          @"UTC+12:00",@"UTC+12:30",@"UTC+13:00",@"UTC+13:30",@"UTC+14:00"];
    }
    return _timeZoneList;
}

@end

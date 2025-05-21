//
//  MKAFMulticaseGroupController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFMulticaseGroupController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTextFieldCell.h"

#import "MKAFMulticaseGroupModel.h"

@interface MKAFMulticaseGroupController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKAFMulticaseGroupModel *dataModel;

@end

@implementation MKAFMulticaseGroupController

- (void)dealloc {
    NSLog(@"MKAFMulticaseGroupController销毁");
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
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return (self.dataModel.isOn ? self.section1List.count : 0);
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
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Multicase Group
        self.dataModel.isOn = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //McAddr
        self.dataModel.mcAddr = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //McAppSkey
        self.dataModel.mcAppSkey = value;
        MKTextFieldCellModel *cellModel = self.section1List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //McNwkSkey
        self.dataModel.mcNwkSkey = value;
        MKTextFieldCellModel *cellModel = self.section1List[2];
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
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Multicase Group";
    cellModel.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *mcAddrModel = [[MKTextFieldCellModel alloc] init];
    mcAddrModel.index = 0;
    mcAddrModel.msg = @"McAddr";
    mcAddrModel.textFieldTextFont = MKFont(13.f);
    mcAddrModel.textFieldType = mk_hexCharOnly;
    mcAddrModel.clearButtonMode = UITextFieldViewModeAlways;
    mcAddrModel.maxLength = 8;
    mcAddrModel.textFieldValue = self.dataModel.mcAddr;
    [self.section1List addObject:mcAddrModel];
    
    MKTextFieldCellModel *mcAppSkeyModel = [[MKTextFieldCellModel alloc] init];
    mcAppSkeyModel.index = 1;
    mcAppSkeyModel.msg = @"McAppSkey";
    mcAppSkeyModel.textFieldTextFont = MKFont(13.f);
    mcAppSkeyModel.textFieldType = mk_hexCharOnly;
    mcAppSkeyModel.clearButtonMode = UITextFieldViewModeAlways;
    mcAppSkeyModel.maxLength = 32;
    mcAppSkeyModel.textFieldValue = self.dataModel.mcAppSkey;
    [self.section1List addObject:mcAppSkeyModel];
    
    MKTextFieldCellModel *mcNwkSkeyModel = [[MKTextFieldCellModel alloc] init];
    mcNwkSkeyModel.index = 2;
    mcNwkSkeyModel.msg = @"McNwkSkey";
    mcNwkSkeyModel.textFieldTextFont = MKFont(13.f);
    mcNwkSkeyModel.textFieldType = mk_hexCharOnly;
    mcNwkSkeyModel.clearButtonMode = UITextFieldViewModeAlways;
    mcNwkSkeyModel.maxLength = 32;
    mcNwkSkeyModel.textFieldValue = self.dataModel.mcNwkSkey;
    [self.section1List addObject:mcNwkSkeyModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Multicase Group";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFMulticaseGroupController", @"af_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (MKAFMulticaseGroupModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFMulticaseGroupModel alloc] init];
    }
    return _dataModel;
}


@end

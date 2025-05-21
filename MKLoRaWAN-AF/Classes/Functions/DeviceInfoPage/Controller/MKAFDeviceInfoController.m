//
//  MKAFDeviceInfoController.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKAFDeviceInfoController.h"

#import <MessageUI/MessageUI.h>

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"

#import "MKTableSectionLineHeader.h"

#import "MKAFConnectModel.h"

#import "MKAFTextButtonCell.h"

#import "MKAFDeviceInfoModel.h"

#import "MKAFUpdateController.h"
#import "MKAFSelftestController.h"
#import "MKAFDebuggerController.h"
#import "MKAFBatteryConsumptionController.h"

@interface MKAFDeviceInfoController ()<MFMailComposeViewControllerDelegate,
UITableViewDelegate,
UITableViewDataSource,
MKAFTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKAFDeviceInfoModel *dataModel;

@property (nonatomic, assign)BOOL onlyBattery;

/// 用户进入dfu页面开启升级模式，返回该页面，不需要读取任何的数据
@property (nonatomic, assign)BOOL isDfuModel;

@end

@implementation MKAFDeviceInfoController

- (void)dealloc {
    NSLog(@"MKAFDeviceInfoController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.isDfuModel) {
        //用户进入dfu页面开启升级模式，返回该页面，不需要读取任何的数据
        [self readDataFromDevice];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceStartDFUProcess)
                                                 name:@"mk_af_startDfuProcessNotification"
                                               object:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:  //取消
            break;
        case MFMailComposeResultSaved:      //用户保存
            break;
        case MFMailComposeResultSent:       //用户点击发送
            [self.view showCentralToast:@"send success"];
            break;
        case MFMailComposeResultFailed: //用户尝试保存或发送邮件失败
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
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
    if (indexPath.section == 5 && indexPath.row == 0) {
        //Battery Consumption Information
        MKAFBatteryConsumptionController *vc = [[MKAFBatteryConsumptionController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 6 && indexPath.row == 0) {
        //Debugger Mode
        MKAFDebuggerController *vc = [[MKAFDebuggerController alloc] init];
        vc.macAddress = self.dataModel.macAddress;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 7 && indexPath.row == 0) {
        //Decoder Export
        [self exportDecoder];
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
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    if (section == 6) {
        return self.section6List.count;
    }
    if (section == 7) {
        return self.section7List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKAFTextButtonCell *cell = [MKAFTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section2List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section3List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 4) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section4List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 5) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section5List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 6) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section6List[indexPath.row];
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel =  self.section7List[indexPath.row];
    return cell;
}

#pragma mark - MKAFTextButtonCellDelegate
/// 用户点击了右侧按钮
/// @param index cell所在序列号
- (void)af_textButtonCell_buttonAction:(NSInteger)index {
    if (index == 0) {
        //DFU
        MKAFUpdateController *vc = [[MKAFUpdateController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - note
- (void)deviceStartDFUProcess {
    self.isDfuModel = YES;
}

#pragma mark - event method
- (void)pushSelftestInterface {
    MKAFSelftestController *vc = [[MKAFSelftestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - export decoder
- (void)exportDecoder {
    NSDictionary *parameters = @{
        @"iBeaconFlag": self.dataModel.beaconContent,
        @"EddystoneUIDFlag": self.dataModel.uidContent,
        @"EddystoneURLFlag": self.dataModel.urlContent,
        @"EddystoneTLMFlag": self.dataModel.tlmContent,
        @"BXPiBeaconFlag": self.dataModel.bxpBeaconContent,
        @"BXPDeviceInfoFlag": self.dataModel.bxpDeviceInfoContent,
        @"BXPACCFlag": self.dataModel.bxpAccContent,
        @"BXPTHFlag": self.dataModel.bxpTHContent,
        @"BXPButtonFlag": self.dataModel.bxpBtnContent,
        @"BXPTagFlag": self.dataModel.bxpTSContent,
        @"OtherTypeFlag": self.dataModel.otherContent,
        @"BXPPirFlag": self.dataModel.bxpPirContent,
        @"BXPTofFlag": self.dataModel.bxpTofContent
    };
    // 2. 生成纯参数TXT内容
    NSString *configContent = [self generateFullJSTXTWithParameters:parameters];
    NSString *txtFilePath = [self saveConfigTXT:configContent];
    [self sendConfigFileByEmail:txtFilePath];
}

#pragma mark - 参数提取与替换
- (NSString *)generateFullJSTXTWithParameters:(NSDictionary *)parameters {
    // 1. 读取原始JS文件全部内容
    NSString *jsPath = [self loadJsPath];
        
    // 2. 读取原始JS内容
    NSMutableString *jsContent = [NSMutableString stringWithContentsOfFile:jsPath
                                                                encoding:NSUTF8StringEncoding
                                                                   error:nil];
    
    // 3. 定义参数替换字典（包含所有可能的参数格式）
    NSDictionary *paramReplacements = @{
        @"iBeaconFlag": @"(0x01FF|\\d+)",
        @"EddystoneUIDFlag": @"(0xFF|\\d+)",
        @"EddystoneURLFlag": @"(0x7F|\\d+)",
        @"EddystoneTLMFlag": @"(0x03FF|\\d+)",
        @"BXPiBeaconFlag": @"(0x07FF|\\d+)",
        @"BXPDeviceInfoFlag": @"(0x1FFF|\\d+)",
        @"BXPACCFlag": @"(0x1FFF|\\d+)",
        @"BXPTHFlag": @"(0x07FF|\\d+)",
        @"BXPButtonFlag": @"(0x03FFFF|\\d+)",
        @"BXPTagFlag": @"(0x0FFF|\\d+)",
        @"OtherTypeFlag": @"(0x1F|\\d+)",
        @"BXPPirFlag": @"(0x3FFF|\\d+)",
        @"BXPTofFlag": @"(0x0FFF|\\d+)"
    };
    
    // 4. 执行精准替换（保留原始格式）
    for (NSString *paramName in parameters.allKeys) {
        NSString *pattern = [NSString stringWithFormat:@"var %@ = %@;",
                           paramName,
                           paramReplacements[paramName]];
        
        NSString *replacement = [NSString stringWithFormat:@"var %@ = %@;",
                                paramName,
                                parameters[paramName]];
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                             options:0
                                                                               error:nil];
        [regex replaceMatchesInString:jsContent
                              options:0
                                range:NSMakeRange(0, jsContent.length)
                         withTemplate:replacement];
    }
    
    // 5. 添加生成标记
    [jsContent insertString:[NSString stringWithFormat:@"// Config generated on %@\n", [NSDate date]]
                    atIndex:0];
    
    return jsContent;
}

#pragma mark - 文件操作
- (NSString *)saveConfigTXT:(NSString *)content {
    NSString *fileName = @"LW003-B-PRO decoder.txt";
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject] stringByAppendingPathComponent:fileName];
    
    [content writeToFile:filePath
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:nil];
    
    return filePath;
}

#pragma mark - 邮件发送
- (void)sendConfigFileByEmail:(NSString *)filePath {
    if (![MFMailComposeViewController canSendMail]) {
        //如果是未绑定有效的邮箱，则跳转到系统自带的邮箱去处理
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"MESSAGE://"]
                                          options:@{}
                                completionHandler:nil];
        return;
    }
    
    MFMailComposeViewController *mailer = [MFMailComposeViewController new];
    mailer.mailComposeDelegate = self;
    [mailer setSubject:@"LW003-B-PRO-decoder"];
    [mailer setMessageBody:@"LW003-B-PRO decoder" isHTML:NO];
    [mailer addAttachmentData:[NSData dataWithContentsOfFile:filePath]
                     mimeType:@"text/plain"
                     fileName:[filePath lastPathComponent]];
    
    [self presentViewController:mailer animated:YES completion:nil];
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self updateCellDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateCellDatas {
    if (ValidStr(self.dataModel.software)) {
        MKNormalTextCellModel *softwareModel = self.section0List[0];
        softwareModel.rightMsg = self.dataModel.software;
    }
    if (ValidStr(self.dataModel.firmware)) {
        MKAFTextButtonCellModel *firmwareModel = self.section1List[0];
        firmwareModel.rightMsg = self.dataModel.firmware;
    }
    if (ValidStr(self.dataModel.hardware)) {
        MKNormalTextCellModel *hardware = self.section2List[0];
        hardware.rightMsg = self.dataModel.hardware;
    }
    
    if (ValidStr(self.dataModel.battery)) {
        MKNormalTextCellModel *soc = self.section3List[0];
        soc.rightMsg = [NSString stringWithFormat:@"%@%@",self.dataModel.battery,@"V"];
    }
    
    if (ValidStr(self.dataModel.macAddress)) {
        MKNormalTextCellModel *mac = self.section4List[0];
        mac.rightMsg = self.dataModel.macAddress;
    }
    if (ValidStr(self.dataModel.productMode)) {
        MKNormalTextCellModel *produceModel = self.section4List[1];
        produceModel.rightMsg = self.dataModel.productMode;
    }
    
    if (ValidStr(self.dataModel.manu)) {
        MKNormalTextCellModel *manuModel = self.section4List[2];
        manuModel.rightMsg = self.dataModel.manu;
    }
    
    [self.tableView reloadData];
}

- (NSString *)loadJsPath {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"MKAFDeviceInfoController")];
    NSString *bundlePath = [bundle pathForResource:@"MKLoRaWAN-AF" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    return [resourceBundle pathForResource:@"LW003_B_PRO" ofType:@"js"];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    
    for (NSInteger i = 0; i < 8; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Software Version";
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKAFTextButtonCellModel *cellModel = [[MKAFTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.leftMsg = @"Firmware Version";
    cellModel.rightButtonTitle = @"DFU";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Hardware Version";
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Battery Voltage";
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"MAC Address";
    [self.section4List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Product Model";
    [self.section4List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Manufacture";
    [self.section4List addObject:cellModel3];
}

- (void)loadSection5Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Battery Consumption Information";
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Debugger Mode";
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Decoder Export";
    [self.section7List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device Information";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSelftestInterface)];
    gesture.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:gesture];
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKAFDeviceInfoModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKAFDeviceInfoModel alloc] init];
    }
    return _dataModel;
}

@end

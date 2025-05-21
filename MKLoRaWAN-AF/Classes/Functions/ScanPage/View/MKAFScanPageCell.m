//
//  MKAFScanPageCell.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFScanPageCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKAFScanPageModel.h"

static CGFloat const offset_X = 15.f;
static CGFloat const rssiIconWidth = 20.f;
static CGFloat const rssiIconHeight = 14.f;
static CGFloat const connectButtonWidth = 80.f;
static CGFloat const connectButtonHeight = 30.f;
static CGFloat const batteryIconWidth = 22.f;
static CGFloat const batteryIconHeight = 12.f;

@interface MKAFScanPageCell ()

@property (nonatomic, strong)UIImageView *rssiIcon;

@property (nonatomic, strong)UILabel *rssiLabel;

@property (nonatomic, strong)UILabel *deviceNameLabel;

@property (nonatomic, strong)UILabel *macLabel;

@property (nonatomic, strong)UIButton *connectButton;

@property (nonatomic, strong)UIImageView *tempIcon;

@property (nonatomic, strong)UILabel *tempLabel;

@property (nonatomic, strong)UIImageView *humidityIcon;

@property (nonatomic, strong)UILabel *humidityLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIImageView *batteryIcon;

@property (nonatomic, strong)UILabel *batteryLabel;

@property (nonatomic, strong)UILabel *bottomLabel;

@end

@implementation MKAFScanPageCell

+ (MKAFScanPageCell *)initCellWithTableView:(UITableView *)tableView {
    MKAFScanPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKAFScanPageCellIdenty"];
    if (!cell) {
        cell = [[MKAFScanPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKAFScanPageCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rssiIcon];
        [self.contentView addSubview:self.rssiLabel];
        [self.contentView addSubview:self.deviceNameLabel];
        [self.contentView addSubview:self.macLabel];
        [self.contentView addSubview:self.connectButton];
        [self.contentView addSubview:self.tempIcon];
        [self.contentView addSubview:self.tempLabel];
        [self.contentView addSubview:self.humidityIcon];
        [self.contentView addSubview:self.humidityLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.batteryIcon];
        [self.contentView addSubview:self.batteryLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.rssiIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(10.f);
        make.width.mas_equalTo(rssiIconWidth);
        make.height.mas_equalTo(rssiIconHeight);
    }];
    [self.rssiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rssiIcon.mas_centerX);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(self.rssiIcon.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.connectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-offset_X);
        make.width.mas_equalTo(connectButtonWidth);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(connectButtonHeight);
    }];
    CGFloat nameWidth = (kViewWidth - 2 * offset_X - rssiIconWidth - 10.f - 8.f - connectButtonWidth);
    CGSize nameSize = [NSString sizeWithText:self.deviceNameLabel.text
                                     andFont:self.deviceNameLabel.font
                                  andMaxSize:CGSizeMake(nameWidth, MAXFLOAT)];
    [self.deviceNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rssiIcon.mas_right).mas_offset(15.f);
        make.centerY.mas_equalTo(self.rssiIcon.mas_centerY);
        make.right.mas_equalTo(self.connectButton.mas_left).mas_offset(-8.f);
        make.height.mas_equalTo(nameSize.height);
    }];
    [self.macLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deviceNameLabel.mas_left);
        make.right.mas_equalTo(self.connectButton.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.deviceNameLabel.mas_bottom).mas_offset(3.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.batteryIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.width.mas_equalTo(batteryIconWidth);
        make.top.mas_equalTo(self.macLabel.mas_bottom).mas_offset(15.f);
        make.height.mas_equalTo(batteryIconHeight);
    }];
    [self.batteryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.batteryIcon.mas_centerX);
        make.width.mas_equalTo(50.f);
        make.top.mas_equalTo(self.batteryIcon.mas_bottom).mas_offset(2.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.tempIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.batteryIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.batteryIcon.mas_bottom).mas_offset(2.f);
        make.height.mas_equalTo(20.f);
    }];
    [self.tempLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.tempIcon.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.humidityIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.batteryIcon.mas_bottom).mas_offset(2.f);
        make.height.mas_equalTo(20.f);
    }];
    [self.humidityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.humidityIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.tempIcon.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.connectButton.mas_left);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.tempIcon.mas_centerY);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deviceNameLabel.mas_left);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.tempIcon.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)connectButtonPressed {
    if ([self.delegate respondsToSelector:@selector(af_scanCellConnectButtonPressed:)]) {
        [self.delegate af_scanCellConnectButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKAFScanPageModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKAFScanPageModel.class]) {
        return;
    }
    //顶部
    self.rssiLabel.text = [NSString stringWithFormat:@"%lddBm",(long)_dataModel.rssi];
    self.deviceNameLabel.text = (ValidStr(_dataModel.deviceName) ? _dataModel.deviceName : @"N/A");
    self.macLabel.text = [@"MAC: " stringByAppendingString:(ValidStr(_dataModel.macAddress) ? _dataModel.macAddress : @"N/A")];
    self.timeLabel.text = _dataModel.scanTime;
    self.connectButton.hidden = !_dataModel.connectable;
    if (_dataModel.lowPower) {
        //低电
        self.batteryIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_lowBatteryIcon.png");
    }else {
        self.batteryIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_batteryIcon.png");
    }
    if ([_dataModel.deviceType isEqualToString:@"00"]) {
        if (_dataModel.lowPower) {
            self.batteryLabel.text = @"Low";
        }else {
            self.batteryLabel.text = @"Full";
        }
    }else {
        self.batteryLabel.text = [NSString stringWithFormat:@"%@%@",_dataModel.battery,@"%"];
    }
    if ([_dataModel.temperature isEqualToString:@"ffff"]) {
        //数据无效
        self.tempIcon.hidden = YES;
        self.tempLabel.text = @"";
    }else {
        self.tempIcon.hidden = NO;
        self.tempLabel.text = [_dataModel.temperature stringByAppendingString:@" °C"];
    }
    if ([_dataModel.humidity isEqualToString:@"ffff"]) {
        //数据无效
        self.humidityIcon.hidden = YES;
        self.humidityLabel.text = @"";
    }else {
        self.humidityIcon.hidden = NO;
        self.humidityLabel.text = [_dataModel.humidity stringByAppendingString:@" %RH"];
    }
    NSString *txPower = (_dataModel.txPower ? [NSString stringWithFormat:@"%@%@",_dataModel.txPower,@"dBm"] : @"N/A");
    self.bottomLabel.text = [NSString stringWithFormat:@"%@: %@     %@",@"Tx Power",txPower,[NSString stringWithFormat:@"%@%@",_dataModel.voltage,@"V"]];
}

#pragma mark - getter
- (UIImageView *)rssiIcon {
    if (!_rssiIcon) {
        _rssiIcon = [[UIImageView alloc] init];
        _rssiIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_rssiIcon.png");
    }
    return _rssiIcon;
}

- (UILabel *)rssiLabel {
    if (!_rssiLabel) {
        _rssiLabel = [[UILabel alloc] init];
        _rssiLabel.textColor = RGBCOLOR(102, 102, 102);
        _rssiLabel.textAlignment = NSTextAlignmentCenter;
        _rssiLabel.font = MKFont(10.f);
    }
    return _rssiLabel;
}

- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.textAlignment = NSTextAlignmentLeft;
        _deviceNameLabel.font = MKFont(15.f);
        _deviceNameLabel.textColor = DEFAULT_TEXT_COLOR;
    }
    return _deviceNameLabel;
}

- (UILabel *)macLabel {
    if (!_macLabel) {
        _macLabel = [self createLabelWithFont:MKFont(12.f)];
    }
    return _macLabel;
}

- (UIButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setBackgroundColor:NAVBAR_COLOR_MACROS];
        [_connectButton setTitle:@"CONNECT" forState:UIControlStateNormal];
        [_connectButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_connectButton.titleLabel setFont:MKFont(15.f)];
        [_connectButton.layer setMasksToBounds:YES];
        [_connectButton.layer setCornerRadius:10.f];
        [_connectButton addTarget:self
                           action:@selector(connectButtonPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = DEFAULT_TEXT_COLOR;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = MKFont(10.f);
        _timeLabel.text = @"N/A";
    }
    return _timeLabel;
}

- (UIImageView *)tempIcon {
    if (!_tempIcon) {
        _tempIcon = [[UIImageView alloc] init];
        _tempIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_temperature.png");
    }
    return _tempIcon;
}

- (UILabel *)tempLabel {
    if (!_tempLabel) {
        _tempLabel = [self createLabelWithFont:MKFont(10.f)];
    }
    return _tempLabel;
}

- (UIImageView *)humidityIcon {
    if (!_humidityIcon) {
        _humidityIcon = [[UIImageView alloc] init];
        _humidityIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_humidity.png");
    }
    return _humidityIcon;
}

- (UILabel *)humidityLabel {
    if (!_humidityLabel) {
        _humidityLabel = [self createLabelWithFont:MKFont(10.f)];
    }
    return _humidityLabel;
}

- (UIImageView *)batteryIcon {
    if (!_batteryIcon) {
        _batteryIcon = [[UIImageView alloc] init];
        _batteryIcon.image = LOADICON(@"MKLoRaWAN-AF", @"MKAFScanPageCell", @"af_scan_batteryIcon.png");
    }
    return _batteryIcon;
}

- (UILabel *)batteryLabel {
    if (!_batteryLabel) {
        _batteryLabel = [self createLabelWithFont:MKFont(10.f)];
        _batteryLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _batteryLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [self createLabelWithFont:MKFont(10.f)];
        _bottomLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _bottomLabel;
}

- (UILabel *)createLabelWithFont:(UIFont *)font {
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.textColor = RGBCOLOR(102, 102, 102);
    msgLabel.textAlignment = NSTextAlignmentLeft;
    msgLabel.font = font;
    return msgLabel;
}

@end

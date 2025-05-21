//
//  MKAFBatteryInfoCell.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKAFBatteryInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKAFBatteryInfoCellModel
@end

@interface MKAFBatteryInfoCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *scanTimeLabel;

@property (nonatomic, strong)UILabel *redLightLabel;

@property (nonatomic, strong)UILabel *greenLightLabel;

@property (nonatomic, strong)UILabel *blueLightLabel;

@property (nonatomic, strong)UILabel *axisSleepLabel;

@property (nonatomic, strong)UILabel *axisWakeupLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@property (nonatomic, strong)UILabel *batteryPowerLabel;

@end

@implementation MKAFBatteryInfoCell

+ (MKAFBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKAFBatteryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKAFBatteryInfoCellIdenty"];
    if (!cell) {
        cell = [[MKAFBatteryInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKAFBatteryInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.scanTimeLabel];
        [self.contentView addSubview:self.redLightLabel];
        [self.contentView addSubview:self.greenLightLabel];
        [self.contentView addSubview:self.blueLightLabel];
        [self.contentView addSubview:self.axisSleepLabel];
        [self.contentView addSubview:self.axisWakeupLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
        [self.contentView addSubview:self.batteryPowerLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.workTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.scanTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.redLightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.scanTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.greenLightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.redLightLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.blueLightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.greenLightLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.axisSleepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.blueLightLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.axisWakeupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.axisSleepLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.axisWakeupLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.batteryPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKAFBatteryInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKAFBatteryInfoCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.scanTimeLabel.text = [SafeStr(_dataModel.scanTime) stringByAppendingString:@"s"];
    self.redLightLabel.text = [SafeStr(_dataModel.redIndicateTotalTime) stringByAppendingString:@"s"];
    self.greenLightLabel.text = [SafeStr(_dataModel.greenIndicateTotalTime) stringByAppendingString:@"s"];
    self.blueLightLabel.text = [SafeStr(_dataModel.blueIndicateTotalTime) stringByAppendingString:@"s"];
    self.axisSleepLabel.text = [SafeStr(_dataModel.axisSleepTimes) stringByAppendingString:@"s"];
    self.axisWakeupLabel.text = [SafeStr(_dataModel.axisWakeupTimes) stringByAppendingString:@"s"];
    self.loraPowerLabel.text = [SafeStr(_dataModel.loraPowerConsumption) stringByAppendingString:@" mAS"];
    self.loraSendCountLabel.text = [SafeStr(_dataModel.loraSendCount) stringByAppendingString:@" times"];
    self.batteryPowerLabel.text = [NSString stringWithFormat:@"%.3f %@",([_dataModel.batteryPower integerValue] * 0.001),@"mAH"];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)workTimeLabel {
    if (!_workTimeLabel) {
        _workTimeLabel = [self fetchValueLabel];
    }
    return _workTimeLabel;
}

- (UILabel *)advCountLabel {
    if (!_advCountLabel) {
        _advCountLabel = [self fetchValueLabel];
    }
    return _advCountLabel;
}

- (UILabel *)scanTimeLabel {
    if (!_scanTimeLabel) {
        _scanTimeLabel = [self fetchValueLabel];
    }
    return _scanTimeLabel;
}

- (UILabel *)redLightLabel {
    if (!_redLightLabel) {
        _redLightLabel = [self fetchValueLabel];
    }
    return _redLightLabel;
}

- (UILabel *)greenLightLabel {
    if (!_greenLightLabel) {
        _greenLightLabel = [self fetchValueLabel];
    }
    return _greenLightLabel;
}

- (UILabel *)blueLightLabel {
    if (!_blueLightLabel) {
        _blueLightLabel = [self fetchValueLabel];
    }
    return _blueLightLabel;
}

- (UILabel *)axisSleepLabel {
    if (!_axisSleepLabel) {
        _axisSleepLabel = [self fetchValueLabel];
    }
    return _axisSleepLabel;
}

- (UILabel *)axisWakeupLabel {
    if (!_axisWakeupLabel) {
        _axisWakeupLabel = [self fetchValueLabel];
    }
    return _axisWakeupLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)batteryPowerLabel {
    if (!_batteryPowerLabel) {
        _batteryPowerLabel = [self fetchValueLabel];
    }
    return _batteryPowerLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end

//
//  MKAFSynDataCell.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/6/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKAFSynDataCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

static NSString *const MKAFSynDataCellIdenty = @"MKAFSynDataCellIdenty";

@interface MKAFSynDataCell ()

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UILabel *macAddressLabel;

@property (nonatomic, strong)UILabel *rssiLabel;

@property (nonatomic, strong)UILabel *deviceTypeLabel;

@property (nonatomic, strong)UILabel *rawDataLabel;

@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong)NSArray *timeZoneList;

@end

@implementation MKAFSynDataCell

+ (MKAFSynDataCell *)initCellWithTableView:(UITableView *)tableView {
    MKAFSynDataCell *cell = [tableView dequeueReusableCellWithIdentifier:MKAFSynDataCellIdenty];
    if (!cell) {
        cell = [[MKAFSynDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MKAFSynDataCellIdenty];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = COLOR_WHITE_MACROS;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.macAddressLabel];
        [self.contentView addSubview:self.rssiLabel];
        [self.contentView addSubview:self.deviceTypeLabel];
        [self.contentView addSubview:self.rawDataLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.macAddressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.rssiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.macAddressLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    [self.deviceTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.rssiLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
    CGSize rawDataSize = [NSString sizeWithText:self.rawDataLabel.text
                                        andFont:MKFont(14.f)
                                     andMaxSize:CGSizeMake(kViewWidth - 30, MAXFLOAT)];
    [self.rawDataLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.deviceTypeLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(rawDataSize.height);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
}

#pragma mark -

+ (CGFloat)fetchCellHeight:(NSDictionary *)dataDic {
    NSString *tempRawData = @"Raw Data: N/A";
    if (ValidStr(dataDic[@"rawData"])) {
        tempRawData = [@"Raw Data: " stringByAppendingString:dataDic[@"rawData"]];
    }
    CGSize rawDataSize = [NSString sizeWithText:tempRawData
                                        andFont:MKFont(14.f)
                                     andMaxSize:CGSizeMake(kViewWidth - 30, MAXFLOAT)];
    CGFloat rawDataHeight = MAX(rawDataSize.height, MKFont(14.f).lineHeight);
    return (4 * MKFont(14.f).lineHeight + rawDataHeight + 30.f + 25.f);
}

- (void)setDataModel:(NSDictionary *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!ValidDict(_dataModel)) {
        return;
    }
    
    if (ValidStr(dataModel[@"timestamp"])) {
        NSInteger timezoneIndex = [dataModel[@"timezone"] integerValue] + 24;
        NSString *timeZone = self.timeZoneList[timezoneIndex];
        self.timeLabel.text = [NSString stringWithFormat:@"Time: %@ %@",dataModel[@"timestamp"],timeZone];
    }else {
        self.timeLabel.text = @"Time: N/A";
    }
    if (ValidStr(dataModel[@"macAddress"])) {
        self.macAddressLabel.text = [@"MAC Address:" stringByAppendingString:dataModel[@"macAddress"]];
    }else {
        self.macAddressLabel.text = @"MAC Address: N/A";
    }
    if (ValidStr(dataModel[@"rssi"])) {
        NSString *value = [NSString stringWithFormat:@"%@%@",dataModel[@"rssi"],@"dBm"];
        self.rssiLabel.text = [@"RSSI:" stringByAppendingString:value];
    }else {
        self.rssiLabel.text = @"RSSI: N/A";
    }
    if (ValidStr(dataModel[@"deviceType"])) {
        self.deviceTypeLabel.text = [@"Device Type:" stringByAppendingString:dataModel[@"deviceType"]];
    }else {
        self.deviceTypeLabel.text = @"Device Type: N/A";
    }
    if (ValidStr(dataModel[@"rawData"])) {
        self.rawDataLabel.text = [@"Raw Data: " stringByAppendingString:dataModel[@"rawData"]];
    }else {
        self.rawDataLabel.text = @"Raw Data: N/A";
    }
    [self setNeedsLayout];
}

#pragma mark - setter & getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [self createMsgLabel];
        _timeLabel.text = @"Time:";
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

- (UILabel *)macAddressLabel {
    if (!_macAddressLabel) {
        _macAddressLabel = [self createMsgLabel];
        _macAddressLabel.text = @"MAC Address:";
    }
    return _macAddressLabel;
}

- (UILabel *)rssiLabel {
    if (!_rssiLabel) {
        _rssiLabel = [self createMsgLabel];
        _rssiLabel.text = @"RSSI:";
    }
    return _rssiLabel;
}

- (UILabel *)deviceTypeLabel {
    if (!_deviceTypeLabel) {
        _deviceTypeLabel = [self createMsgLabel];
        _deviceTypeLabel.text = @"Device Type:";
    }
    return _deviceTypeLabel;
}

- (UILabel *)rawDataLabel {
    if (!_rawDataLabel) {
        _rawDataLabel = [self createMsgLabel];
        _rawDataLabel.text = @"Raw Data:";
        _rawDataLabel.numberOfLines = 0;
    }
    return _rawDataLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView;
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

- (UILabel *)createMsgLabel {
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.textColor = UIColorFromRGB(0x333333);
    msgLabel.textAlignment = NSTextAlignmentLeft;
    msgLabel.font = MKFont(14.f);
    return msgLabel;
}

@end

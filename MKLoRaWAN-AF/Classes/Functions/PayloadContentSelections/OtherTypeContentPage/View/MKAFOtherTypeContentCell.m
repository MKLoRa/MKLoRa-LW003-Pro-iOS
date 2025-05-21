//
//  MKAFOtherTypeContentCell.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/10/31.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKAFOtherTypeContentCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKAFOtherTypeContentCellModel
@end

@interface MKAFOtherTypeContentCell ()

@property (nonatomic, strong)UIButton *deleteButton;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *dataTypeTextField;

@property (nonatomic, strong)MKTextField *startTextField;

@property (nonatomic, strong)UILabel *symbolLabel;

@property (nonatomic, strong)MKTextField *endTextField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKAFOtherTypeContentCell

+ (MKAFOtherTypeContentCell *)initCellWithTableView:(UITableView *)tableView {
    MKAFOtherTypeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKAFOtherTypeContentCellIdenty"];
    if (!cell) {
        cell = [[MKAFOtherTypeContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKAFOtherTypeContentCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.dataTypeTextField];
        [self.contentView addSubview:self.startTextField];
        [self.contentView addSubview:self.symbolLabel];
        [self.contentView addSubview:self.endTextField];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.dataTypeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(50.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.startTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dataTypeTextField.mas_right).mas_offset(15.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.symbolLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startTextField.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.endTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.symbolLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.endTextField.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)deleteButtonPressed {
    if ([self.delegate respondsToSelector:@selector(af_otherCellDeletedWithNumber:blockIndex:)]) {
        [self.delegate af_otherCellDeletedWithNumber:self.dataModel.blockNumber
                                          blockIndex:self.dataModel.blockIndex];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKAFOtherTypeContentCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.dataTypeTextField.text = SafeStr(_dataModel.dataType);
    self.startTextField.text = SafeStr(_dataModel.startIndex);
    self.endTextField.text = SafeStr(_dataModel.endIndex);
    self.unitLabel.text = SafeStr(_dataModel.unitMsg);
}

#pragma mark - getter
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:LOADICON(@"MKLoRaWAN-AF", @"MKAFOtherTypeContentCell", @"af_content_delete.png") forState:UIControlStateNormal];
        [_deleteButton addTarget:self
                          action:@selector(deleteButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];;
    }
    return _deleteButton;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(12.f);
    }
    return _msgLabel;
}

- (MKTextField *)dataTypeTextField {
    if (!_dataTypeTextField) {
        _dataTypeTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                                  placeHolder:@"Data Type"
                                                                     textType:mk_hexCharOnly];
        _dataTypeTextField.maxLength = 2;
        _dataTypeTextField.font = MKFont(12.f);
        @weakify(self);
        _dataTypeTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(af_otherCellDataTypeChanged:blockNumber:blockIndex:)]) {
                [self.delegate af_otherCellDataTypeChanged:text
                                               blockNumber:self.dataModel.blockNumber
                                                blockIndex:self.dataModel.blockIndex];
            }
        };
    }
    return _dataTypeTextField;
}

- (MKTextField *)startTextField {
    if (!_startTextField) {
        _startTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                               placeHolder:@"1~29"
                                                                  textType:mk_realNumberOnly];
        _startTextField.maxLength = 2;
        _startTextField.font = MKFont(12.f);
        @weakify(self);
        _startTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(af_otherCellStartIndexChanged:blockNumber:blockIndex:)]) {
                [self.delegate af_otherCellStartIndexChanged:text
                                                 blockNumber:self.dataModel.blockNumber
                                                  blockIndex:self.dataModel.blockIndex];
            }
        };
    }
    return _startTextField;
}

- (UILabel *)symbolLabel {
    if (!_symbolLabel) {
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.textColor = DEFAULT_TEXT_COLOR;
        _symbolLabel.textAlignment = NSTextAlignmentCenter;
        _symbolLabel.font = MKFont(12.f);
        _symbolLabel.text = @"~";
    }
    return _symbolLabel;
}

- (MKTextField *)endTextField {
    if (!_endTextField) {
        _endTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                             placeHolder:@"1~29"
                                                                textType:mk_realNumberOnly];
        _endTextField.maxLength = 2;
        _endTextField.font = MKFont(12.f);
        @weakify(self);
        _endTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(af_otherCellEndIndexChanged:blockNumber:blockIndex:)]) {
                [self.delegate af_otherCellEndIndexChanged:text
                                               blockNumber:self.dataModel.blockNumber
                                                blockIndex:self.dataModel.blockIndex];
            }
        };
    }
    return _endTextField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.font = MKFont(12.f);
    }
    return _unitLabel;
}

@end

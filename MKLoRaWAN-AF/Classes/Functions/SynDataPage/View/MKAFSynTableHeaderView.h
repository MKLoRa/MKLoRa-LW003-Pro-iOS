//
//  MKAFSynTableHeaderView.h
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2021/6/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKCustomUIModule/MKTextField.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAFMsgIconButton : UIControl

@property (nonatomic, strong)UIImageView *topIcon;

@property (nonatomic, strong)UILabel *msgLabel;

@end

@interface MKAFSynTableHeaderView : UIView

@property (nonatomic, strong, readonly)MKTextField *textField;

@property (nonatomic, strong, readonly)UIButton *startButton;

@property (nonatomic, strong, readonly)MKAFMsgIconButton *synButton;

@property (nonatomic, strong, readonly)MKAFMsgIconButton *emptyButton;

@property (nonatomic, strong, readonly)MKAFMsgIconButton *exportButton;

@property (nonatomic, strong, readonly)UILabel *sumLabel;

@property (nonatomic, strong, readonly)UILabel *countLabel;

@end

NS_ASSUME_NONNULL_END

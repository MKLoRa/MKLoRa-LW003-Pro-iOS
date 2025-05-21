//
//  Target_LoRaWANAF_Module.m
//  MKLoRaWAN-AF_Example
//
//  Created by aa on 2022/6/9.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANaf_Module.h"

#import "MKAFScanController.h"
//
#import "MKAFAboutController.h"

@implementation Target_LoRaWANAF_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANAF_Module_ScanController:(NSDictionary *)params {
    return [[MKAFScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANAF_Module_AboutController:(NSDictionary *)params {
    return [[MKAFAboutController alloc] init];
}

@end

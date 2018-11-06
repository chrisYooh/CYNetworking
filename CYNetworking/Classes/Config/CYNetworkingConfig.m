//
//  CYNetworkingConfig.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "CYNetworkingConfig.h"

@implementation CYNetworkingConfig

+ (CYNetworkingConfig *)sharedConfig {
    static CYNetworkingConfig *_sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [[CYNetworkingConfig alloc] init];
    });
    return _sharedConfig;
}

@end

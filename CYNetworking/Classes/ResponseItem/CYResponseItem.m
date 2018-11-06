//
//  CYResponseItem.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "CYNetworkingConfig.h"

#import "CYResponseItem.h"

@implementation CYResponseItem

+ (CYResponseItem *)itemWithData:(id)rawData {
    
    CYResponseItem *tmpItem = [[CYResponseItem alloc] init];
    
    tmpItem.rawData = rawData;
    
    /* Json 转换 */
    tmpItem.rawJsonData = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
    
    /* 无需提取解包信息 */
    if (NO == [CYNetworkingConfig sharedConfig].unboxCallback) {
        tmpItem.isSuccess = YES;
        tmpItem.responseData = tmpItem.rawJsonData;
        
        return tmpItem;
    }
    
    /* 解包信息 - 失败*/
    id unBoxData = [CYNetworkingConfig sharedConfig].unboxCallback(tmpItem.rawJsonData);
    if ([unBoxData isKindOfClass:[NSError class]]) {
        NSError *tmpError = (NSError *)unBoxData;
        tmpItem.isSuccess = NO;
        tmpItem.error = tmpError;
        tmpItem.errorCode = tmpError.code;
        tmpItem.errorMessage = tmpError.domain;
        
        return tmpItem;
    }
    
    /* 解包信息 - 成功 */
    tmpItem.isSuccess = YES;
    tmpItem.responseData = unBoxData;
    
    return tmpItem;
}

+ (CYResponseItem *)itemWithError:(NSError *)error {
    
    CYResponseItem *tmpItem = [[CYResponseItem alloc] init];
    tmpItem.isSuccess = NO;
    tmpItem.error = error;
    tmpItem.errorCode = error.code;
    tmpItem.errorMessage = error.domain;
    
    return tmpItem;
}

@end

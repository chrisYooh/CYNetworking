//
//  CYResponseItem.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYNetworkingTypes.h"

NS_ASSUME_NONNULL_BEGIN

@class CYRequestItem;

@interface CYResponseItem : NSObject

@property (nonatomic, strong) CYRequestItem *refReqItem;    /* 关联的请求信息 */

@property (nonatomic, assign) BOOL isSuccess;               /* 请求是否成功 */

/* 错误 */
@property (nonatomic, strong) NSError *error;               /* 错误 */
@property (nonatomic, assign) CYNResponseCode errorCode;    /* 错误代码 */
@property (nonatomic, strong) NSString *errorSubCode;       /* [暂未实现] 错误子代码，如HttpStatus */
@property (nonatomic, strong) NSString *errorMessage;       /* 错误描述 */

/* 接口数据 */
@property (nonatomic, strong) id rawData;                   /* 原始返回数据，未进行任何转换 */
@property (nonatomic, strong) id rawJsonData;               /* 原始返回数据，只进行了Json转换，未解包（提取业务数据） */
@property (nonatomic, strong) id responseData;              /* 业务返回数据，去除了返回框架的业务数据，未提供解包回调时与rawJsonData相同 */

+ (CYResponseItem *)itemWithData:(id)rawData;
+ (CYResponseItem *)itemWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

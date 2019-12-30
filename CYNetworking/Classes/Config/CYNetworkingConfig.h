//
//  CYNetworkingConfig.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYNetworkingTypes.h"

NS_ASSUME_NONNULL_BEGIN

/* 公共解包回调
 * Json Obj 一般是一个 NSDictionArray 结构
 * 返回值：
 *  a 出错时， NSError *
 *  b 正常时， 一个Json对象(一般是NSDictionary *)
 */
typedef id _Nullable (^cyNetworkingUnboxBlock) (id jsonObj);

@interface CYNetworkingConfig : NSObject

@property (nonatomic, assign) BOOL autoLog;                                             /* 是否自动打印日志 */

@property (nonatomic, strong) NSString *defaultHost;                                    /* 默认请求主机(公共地址) */
@property (nonatomic, assign) CYRequestItemReqContentType defaultReqContentType;        /* 默认请求格式 */
@property (nonatomic, assign) CYRequestItemRespContentType defaultRespContentType;      /* 默认答复格式 */
@property (nonatomic, strong) NSDictionary *commonHeaderParams;                         /* 公共头参数 */
@property (nonatomic, strong) NSDictionary *commonBodyParams;                           /* 公共Body参数 */

@property (nonatomic, copy) cyNetworkingUnboxBlock unboxCallback;                       /* 解包回调, 为nil时不解包 */

+ (CYNetworkingConfig *)sharedConfig;

@end

NS_ASSUME_NONNULL_END

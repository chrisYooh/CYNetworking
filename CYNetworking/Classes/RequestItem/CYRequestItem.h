//
//  CYRequestItem.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYNetworkingTypes.h"

NS_ASSUME_NONNULL_BEGIN

@class CYResponseItem;

typedef void (^cyRequestBlock) (CYResponseItem *respItem);

@interface CYRequestItem : NSObject

@property (nonatomic, strong) NSString *baseUrl;            /* 请求基地址，如"http://m.test.nonobank.com" */
@property (nonatomic, strong) NSString *businessUrl;        /* 请求业务地址，如"banners/loadBanners" */
@property (nonatomic, strong) NSString *absoluteUrl;        /* 独立请求地址，设定该地址后，baseUrl, businessUrl不再生效 */

@property (nonatomic, assign) CYRequestType reqType;                            /* 请求类型，如Get */
@property (nonatomic, assign) CYRequestItemReqContentType reqContentType;       /* 请求信息的内容格式，默认不设置（AF的默认格式） */
@property (nonatomic, assign) CYRequestItemRespContentType respContentType;     /* 答复信息的内容格式，默认为HTTP(二进制）*/

@property (nonatomic, strong) NSDictionary *headerParas;    /* 希望添加到请求头的参数 */
@property (nonatomic, strong) NSDictionary *parameters;     /* 请求的业务相关的参数 */

/* Upload */
@property (nonatomic, strong) NSString *uploadKey;          /* 上传Key */
@property (nonatomic, strong) NSData *uploadData;           /* 上传时使用，目前只支持单数据上传 */
@property (nonatomic, strong) NSString *uploadDstFileName;  /* 上传目标文件名 */
@property (nonatomic, strong) NSString *uploadDataType;     /* 上传数据的格式 */

- (void)startWithCallback:(cyRequestBlock)callback;
- (void)cancelRequest;

@end

NS_ASSUME_NONNULL_END

//
//  CYRequestItem.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+CYCategory.h"
#import "CYNetworkingConfig.h"
#import "CYResponseItem.h"
#import "CYRequestPool.h"

#import "CYRequestItem.h"

@interface CYRequestItem()

@property (nonatomic, weak) NSURLSessionDataTask *reqSession;
@property (nonatomic, assign) BOOL isRequesting;                    /* 是否正在请求 */

@end

@implementation CYRequestItem

- (id)init {
    
    self = [super init];
    
    if (self) {
        _baseUrl = [CYNetworkingConfig sharedConfig].defaultHost;
        _businessUrl = nil;
        _reqContentType = [CYNetworkingConfig sharedConfig].defaultReqContentType;
        _respContentType = [CYNetworkingConfig sharedConfig].defaultRespContentType;
        _parameters = nil;
        _headerParas = nil;
        
        _isRequesting = NO;
    }
    
    return self;
}

- (NSString *)description {
    
    NSMutableString *tmpStr = [[NSMutableString alloc] initWithString:@""];
    if (nil != _headerParas) {
        [tmpStr appendFormat:@"头参数：%@\n", [self userdefManager].requestSerializer.HTTPRequestHeaders];
    }
    [tmpStr appendFormat:@"请求地址：%@____", [self requestUrlStr]];
    if (nil != _parameters) {
        [tmpStr appendFormat:@"参数：%@___", _parameters];
    }
    
    return [NSString stringWithString:tmpStr];
}

#pragma mark - MISC

- (void)logRequest {
    if (NO == [CYNetworkingConfig sharedConfig].autoLog) {
        return;
    }
    
    NSLog(@"\n【Net Request Start】"
          "\nUrl : %@"
          "\nParas : %@",
          [self requestUrlStr],
          [self requestAllParas]);
}

- (void)logResponse:(CYResponseItem *)respItem {
    
    if (NO == [CYNetworkingConfig sharedConfig].autoLog) {
        return;
    }

    NSLog(@"\n【Request Info】"
          "\nUrl : %@"
          "\nParas : %@",
          [self requestUrlStr],
          [self requestAllParas]);
    
    if (NO == respItem.isSuccess) {
        NSLog(@"%@", respItem.error);
        return;
    }
    
    NSLog(@"\n【Response Info】"
          "\n%@",
          respItem.rawJsonData);
}

#pragma mark - Requet Common

- (AFHTTPSessionManager *)userdefManager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /* Set Request Serializer */
    AFHTTPRequestSerializer *reqSerializer = [self requestSerializer];
    if (nil != reqSerializer) {
        manager.requestSerializer = reqSerializer;
    }
    
    /* Set Response Serializer */
    AFHTTPResponseSerializer *respSerializer = [self responseSerializer];
    if (nil != respSerializer) {
        manager.responseSerializer = respSerializer;
    }
    
    /* Set timeout interval */
    if (nil != _headerParas) {
        [manager setHttpHeader:_headerParas];
        manager.requestSerializer.timeoutInterval = 30;
    }
    
    return manager;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    
    AFHTTPRequestSerializer *tmpSerializer = nil;
    
    if (CYRequestItemReqContentTypeHttp == _reqContentType) {
        tmpSerializer = [AFHTTPRequestSerializer serializer];
        
    } else if (CYRequestItemReqContentTypeJson == _reqContentType) {
        tmpSerializer = [AFJSONRequestSerializer serializer];
        
    } else if (CYRequestItemReqContentTypePlist == _reqContentType) {
        tmpSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    return tmpSerializer;
}

- (AFHTTPResponseSerializer *)responseSerializer {
    
    AFHTTPResponseSerializer *tmpSerializer = [AFHTTPResponseSerializer serializer];
    
    if (CYRequestItemRespContentTypeHttp == _respContentType) {
        tmpSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if (CYRequestItemRespContentTypeJson == _respContentType) {
        tmpSerializer = [AFJSONResponseSerializer serializer];
        
    } else if (CYRequestItemRespContentTypeXmlParser == _respContentType) {
        tmpSerializer = [AFXMLParserResponseSerializer serializer];
        
    }
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
    else if (CYRequestItemRespContentTypeXmlDoc == _respContentType) {
        tmpSerializer = [AFXMLDocumentResponseSerializer serializer];
    }
#endif
    else if (CYRequestItemRespContentTypeXmlPlist == _respContentType) {
        tmpSerializer = [AFPropertyListResponseSerializer serializer];
        
    } else if (CYRequestItemRespContentTypeXmlImage == _respContentType) {
        tmpSerializer = [AFImageResponseSerializer serializer];
        
    } else if (CYRequestItemRespContentTypeXmlCompound == _respContentType) {
        tmpSerializer = [AFCompoundResponseSerializer serializer];
        
    }
    
    return tmpSerializer;
}

- (NSString *)requestUrlStr {
    
    NSString *urlStr = nil;
    
    if (0 != _absoluteUrl.length) {
        return _absoluteUrl;
    }
    
    if (nil != _businessUrl) {
        urlStr = [NSString stringWithFormat:@"%@/%@", _baseUrl, _businessUrl];
    } else {
        urlStr = _baseUrl;
    }
    
    return urlStr;
}

- (NSDictionary *)requestAllParas {
    NSMutableDictionary *tmpMulDic = [[NSMutableDictionary alloc] init];
    [tmpMulDic addEntriesFromDictionary:[CYNetworkingConfig sharedConfig].commonBodyParams];
    [tmpMulDic addEntriesFromDictionary:_parameters];
    return tmpMulDic.copy;
}

/* 上传参数处理 */
- (void)formData:(id<AFMultipartFormData>)formData fillParas:(NSDictionary *)paras {
    NSArray *keyArray = paras.allKeys;
    for (NSString *tmpKey in keyArray) {
        NSString *tmpVal = [paras objectForKey:tmpKey];
        [formData appendPartWithFormData:[tmpVal dataUsingEncoding:NSUTF8StringEncoding] name:tmpKey];
    }
}

#pragma mark - Request Get

- (void)getWithCallback:(cyRequestBlock)callback {
    
    NSMutableString *getReqStr = [[NSMutableString alloc] initWithString:@""];
    [getReqStr appendString:[self requestUrlStr]];
    [getReqStr appendFormat:@"?%@", [self parametersGetStr]];
    
    @weakify(self);
    _reqSession =
    [[self userdefManager]
     GET:getReqStr
     parameters:nil
     progress:^(NSProgress * _Nonnull downloadProgress) {
         /* Do nothing */
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         @strongify(self);
         CYResponseItem *tmpResp = [CYResponseItem itemWithData:responseObject];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         CYResponseItem *tmpResp = [CYResponseItem itemWithError:error];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
     }];
}

- (NSString *)parametersGetStr {
    
    NSDictionary *paraDic = [self requestAllParas];
    
    BOOL isFirstPara = YES;
    NSMutableString *userdefParaStr = [[NSMutableString alloc] init];
    for (NSString *tmpKey in paraDic.allKeys) {
        
        if (YES == isFirstPara) {
            isFirstPara = NO;
        } else {
            [userdefParaStr appendString:@"&"];
        }
        
        [userdefParaStr appendFormat:@"%@=%@", tmpKey, [_parameters objectForKey:tmpKey]];
    }
    
    return userdefParaStr;
}

#pragma mark - Request Post

- (void)postWithCallback:(cyRequestBlock)callback {
    
    @weakify(self);
    _reqSession =
    [[self userdefManager]
     POST:[self requestUrlStr]
     parameters:[self requestAllParas]
     progress:^(NSProgress * _Nonnull uploadProgress) {
         /* Do nothing */
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         @strongify(self);
         CYResponseItem *tmpResp = [CYResponseItem itemWithData:responseObject];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         @strongify(self);
         CYResponseItem *tmpResp = [CYResponseItem itemWithData:error];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
     }];
}

- (void)uploadPostWithCallback:(cyRequestBlock)callback {
    
    @weakify(self);
    _reqSession =
    [[self userdefManager]
     POST:[self requestUrlStr]
     parameters:nil
     constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         @strongify(self);
         
         [self formData:formData fillParas:[self requestAllParas]];
         [formData appendPartWithFileData:self.uploadData
                                     name:self.uploadKey
                                 fileName:self.uploadDstFileName
                                 mimeType:self.uploadDataType];
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         //CYNLog(@"UploadProgress %@", uploadProgress);
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         @strongify(self);
         CYResponseItem *tmpResp = [CYResponseItem itemWithData:responseObject];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         @strongify(self);
         CYResponseItem *tmpResp = [CYResponseItem itemWithData:error];
         tmpResp.refReqItem = self;
         if (nil != callback) {
             callback(tmpResp);
         }
     }];
}

#pragma mark - User Interface

/* 日志、请求池 */
- (void)startWithCallback:(cyRequestBlock)callback {
    
    if (YES == _isRequesting) {
        /* 正在请求 */
        return;
    }
    _isRequesting = YES;
    [[CYRequestPool sharedInstance] pushItem:self];
    
    [self logRequest];
    @weakify(self);
    if (CYRequestTypeGet == _reqType) {
        /* GET */
        [self getWithCallback:^(CYResponseItem * _Nonnull respItem) {
            @strongify(self);
            self.isRequesting = NO;
            [[CYRequestPool sharedInstance] removeItem:self];
            [self logResponse:respItem];
            if (nil != callback) {
                callback(respItem);
            }
        }];
        
    } else if (CYRequestTypePost == _reqType) {
        [self postWithCallback:^(CYResponseItem * _Nonnull respItem) {
            @strongify(self);
            self.isRequesting = NO;
            [[CYRequestPool sharedInstance] removeItem:self];
            [self logResponse:respItem];
            if (nil != callback) {
                callback(respItem);
            }
        }];
        
    } else if (CYRequestTypePostUpload == _reqType) {
        [self uploadPostWithCallback:^(CYResponseItem * _Nonnull respItem) {
            @strongify(self);
            self.isRequesting = NO;
            [[CYRequestPool sharedInstance] removeItem:self];
            [self logResponse:respItem];
            if (nil != callback) {
                callback(respItem);
            }
        }];
    }
    
    else {
        _isRequesting = NO;
        [[CYRequestPool sharedInstance] removeItem:self];
    }
}

- (void)cancelRequest {
    [_reqSession cancel];
    
    _isRequesting = NO;
    [[CYRequestPool sharedInstance] removeItem:self];
}

@end

//
//  CYNetworkingTypes.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#ifndef CYNetworkingTypes_h
#define CYNetworkingTypes_h

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/* 请求类型 */
typedef NS_ENUM (NSInteger, CYRequestType) {
    CYRequestTypeUnknown = -1,
    
    CYRequestTypeGet,
    CYRequestTypePost,
    CYRequestTypePostUpload,    
    CYRequestTypeHead,          /* 暂未支持 */
    CYRequestTypePut,           /* 暂未支持 */
    CYRequestTypeDelete,        /* 暂未支持 */
    CYRequestTypePatch,         /* 暂未支持 */
    
    CYRequestTypeDefault = CYRequestTypeGet,
};

/* 请求数据格式 */
typedef NS_ENUM(NSInteger, CYRequestItemReqContentType) {
    CYRequestItemReqContentTypeUnknown = -1,
    
    CYRequestItemReqContentTypeHttp,            /* Binary */
    CYRequestItemReqContentTypeJson,
    CYRequestItemReqContentTypePlist,
    
    CYRequestItemReqContentTypeDefault = CYRequestItemReqContentTypeHttp,
};

/* 返回数据格式 */
typedef NS_ENUM(NSInteger, CYRequestItemRespContentType) {
    CYRequestItemRespContentTypeUnknown = -1,
    
    CYRequestItemRespContentTypeHttp,           /* Binary */
    CYRequestItemRespContentTypeJson,
    CYRequestItemRespContentTypeXmlParser,
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
    CYRequestItemRespContentTypeXmlDoc,
#endif
    CYRequestItemRespContentTypeXmlPlist,
    CYRequestItemRespContentTypeXmlImage,
    CYRequestItemRespContentTypeXmlCompound,
    
    CYRequestItemRespContentTypeDefault = CYRequestItemRespContentTypeUnknown,
};

/* 错误类型枚举 */
typedef NS_ENUM (NSUInteger, CYNResponseCode) {
    CYNResponseCodeUnknown = -1,        /* 未知错误 */
    CYNResponseCodeSuccess = 0,         /* 无错误 */
    
    CYNResponseCodeHTTPError,           /* http状态码异常 */
    CYNResponseCodeCocoaError,          /* Cocoa错误 */
    
    CYNResponseCodeNoNetWork,           /* 网络不通 */
    CYNResponseCodeURLError,            /* URL异常 */
    CYNResponseCodeTimeout,             /* 请求超时 */
    
    CYNResponseCodeInvalidResponse,     /* 非法返回数据 */
};

#endif /* CYNetworkingTypes_h */

//
//  AFHTTPSessionManager+CYCategory.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (CYCategory)

- (void)setHttpHeader:(NSDictionary *)headerDic;

@end

NS_ASSUME_NONNULL_END

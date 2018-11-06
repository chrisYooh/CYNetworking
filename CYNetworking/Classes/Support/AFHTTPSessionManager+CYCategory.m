//
//  AFHTTPSessionManager+CYCategory.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "AFHTTPSessionManager+CYCategory.h"

@implementation AFHTTPSessionManager (CYCategory)

- (void)setHttpHeader:(NSDictionary *)headerDic {    
    for (NSString *tmpKey in headerDic.allKeys) {
        NSString *tmpVal = [headerDic objectForKey:tmpKey];
        [self.requestSerializer setValue:tmpVal forHTTPHeaderField:tmpKey];
    }
}

@end

//
//  CYRequestPool.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "CYRequestPool.h"

@implementation CYRequestPool

- (id)init {
    self = [super init];
    if (self) {
        _requestsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (CYRequestPool *)sharedInstance {

    static CYRequestPool *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CYRequestPool alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - User Interface

- (void)pushItem:(CYRequestItem *)reqItem {
    [_requestsArray addObject:reqItem];
}

- (void)removeItem:(CYRequestItem *)reqItem {
    [_requestsArray removeObject:reqItem];
}

@end

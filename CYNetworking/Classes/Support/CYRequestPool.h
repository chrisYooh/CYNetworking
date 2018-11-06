//
//  CYRequestPool.h
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CYRequestItem;

@interface CYRequestPool : NSObject

@property (nonatomic, strong) NSMutableArray *requestsArray;

+ (CYRequestPool *)sharedInstance;

- (void)pushItem:(CYRequestItem *)reqItem;
- (void)removeItem:(CYRequestItem *)reqItem;

@end

NS_ASSUME_NONNULL_END

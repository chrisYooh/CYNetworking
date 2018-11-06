//
//  ViewController.m
//  CYNetworking
//
//  Created by Chris on 2018/11/6.
//  Copyright © 2018 杨一凡. All rights reserved.
//

#import "CYNetworking.h"

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CYRequestItem *reqItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _reqItem = [[CYRequestItem alloc] init];
    _reqItem.absoluteUrl = @"https://m.nonobank.com/feserver/common/current/";
    [_reqItem startWithCallback:^(CYResponseItem * _Nonnull respItem) {
        NSLog(@"%@", respItem);
    }];

}

@end

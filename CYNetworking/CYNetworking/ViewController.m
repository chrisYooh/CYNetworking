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
    
//    _reqItem = [[CYRequestItem alloc] init];
//    _reqItem.absoluteUrl = @"http://192.168.5.200:8888";
//    [_reqItem startWithCallback:^(CYResponseItem * _Nonnull respItem) {
//        if (NO == respItem.isSuccess) {
//            NSLog(@"%@", respItem.errorMessage);
//            return ;
//        }
//        NSLog(@"Success");
//    }];
    
    UIImage *tmpImage = [UIImage imageNamed:@"test2"];
    NSData *tmpData = UIImagePNGRepresentation(tmpImage);

    _reqItem = [[CYRequestItem alloc] init];
    _reqItem.reqType = CYRequestTypePost;
    _reqItem.uploadKey = @"image";
    _reqItem.uploadData = tmpData;
    _reqItem.uploadDstFileName = @"xxx.png";
    _reqItem.uploadDataType = @"image/png";
    _reqItem.absoluteUrl = @"http://192.168.5.200:8888/user/reg/";
    _reqItem.parameters = @{@"type1":@"value1"};
    [_reqItem startWithCallback:^(CYResponseItem * _Nonnull respItem) {
        if (NO == respItem.isSuccess) {
            NSLog(@"Error %@", respItem.errorMessage);
            return ;
        }
        NSLog(@"Success %@", respItem.responseData);
    }];
}


@end

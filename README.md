# CYNetworking
Chris Yang Single Networking

## 1.集成
参考Pod：
pod 'CYNetworking', :git => 'https://github.com/chrisYooh/CYNetworking.git', :commit => '6cb7f4e'

## 2.头文件
在需要使用之处添加：
#import <CYNetworking/CYNetworking.h>

## 3.公共配置
在公共场景，比如appLaunch时，配置[主机地址][公共头参数][公共body参数]
```
[CYNetworkingConfig sharedConfig].defaultHost = @"https//...";
[CYNetworkingConfig sharedConfig].commonHeaderParams = {@"A":@"a", @"B":@"b"};
[CYNetworkingConfig sharedConfig].commonBodyParams = {@"C":@"c", @"D":@"d"};
```

## 4.简单请求(不需要关心defaultHost)
```
CYRequestItem *registReqItem = [[CYRequestItem alloc] init];
registReqItem.reqType = CYRequestTypeGet;
registReqItem.absoluteUrl = @"https://...";
registReqItem.parameters = @{@"A":@"a", @"B":@"b"};

[registReqItem startWithCallback:^(CYResponseItem * _Nonnull respItem) {
    if (NO == respItem.isSuccess) {
        /* ERROR */
        return;
    } 
    
    /* Success 处理返回数据*/
    respItem.responseData ...
}
```

## 5.规范请求
```
CYRequestItem *registReqItem = [[CYRequestItem alloc] init];
registReqItem.reqType = CYRequestTypeGet;
registReqItem.businessUrl = @"...";     /* 主机地址统一配置 */
registReqItem.parameters = @{@"A":@"a", @"B":@"b"};

[registReqItem startWithCallback:^(CYResponseItem * _Nonnull respItem) {
    if (NO == respItem.isSuccess) {
        /* ERROR */
        return;
    } 
    
    /* Success 处理返回数据*/
    respItem.responseData ...
}
```


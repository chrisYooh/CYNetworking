# 1 CYNetworking - HttpServerSupport
用NodeJS创建简单的Http服务器，以便进行接口调试

## 1.1 启动办法
1）安装nodeJS
2）进入HttpServer文件夹，
3）使用npm install安装依赖包
4）执行node index.js

## 1.2 接口说明
1）Get测试：127.0.0.1:9999/getTest
接口会返回测试参数
2）Post测试：127.0.0.1:9999/postTest
接口会返回测试参数

# 2 CYNetworking - TcpServer
用NodeJS创建简单的Socket Tcp服务器，以便进行Tcp接口调试

## 2.1 启动办法
1）安装nodeJS
2）进入TcpServer文件夹，
3）执行node index.js

## 2.2 接口说明
1）connect 链接
2）data 处理数据
3）close 关闭链接

# 3 CYNetworking - TcpClient
用NodeJS创建简单的Socket Client服务器，以便配合演示TcpServer功能

## 2.1 启动办法
1）启动TcpServer
2）进入TcpClient文件夹，
3）执行node index.js

## 2.2 测试说明
链接 TcpServer 并向其发送11次内容请求，接受服务器返还的内容答复并打印

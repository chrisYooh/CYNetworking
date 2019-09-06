var net = require('net');

// var HOST = '127.0.0.1';
var HOST = '172.20.10.14';
var PORT = 8888;
var i = 0;

var client = new net.Socket();

client.connect(PORT, HOST, function() {
               console.log('CONNECTED TO: ' + HOST + ':' + PORT);
               // 建立连接后立即向服务器发送数据，服务器将收到这些数据
               client.write('Hello Baby!');
               });

client.on('data', function(data) {
          console.log('DATA: ' + data);
          
          if (i < 10) {
            client.write(i + ' Hello Baby!');
          } else {
            client.destroy();
          }
          i++;
          
          });

client.on('close', function() {
          console.log('Connection closed');
          });

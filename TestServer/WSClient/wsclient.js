// const aa = require('nodejs-websocket')

var WebSocket = require('ws')
// var ws = new WebSocket("wss://echo.websocket.org");
var ws = new WebSocket("ws://172.20.10.6:60009");

ws.onopen = function(evt) {
    console.log("Connection open ...");
    ws.send("Hello WebSockets!");
};

ws.onmessage = function(evt) {
    console.log( "Received Message: " + evt.data);
    ws.close();
};

ws.onclose = function(evt) {
    console.log("Connection closed.");
};

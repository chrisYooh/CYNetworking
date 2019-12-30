var WebSocketServer = require("ws").Server;
var wss = new WebSocketServer({ port: 60009 });

wss.on("connection", function(ws) {

    ws.on('message', function incoming(message) {
        console.log('received: %s', message);
        ws.send("收到");
    });

	ws.send("Welcome to cyber chat");
});

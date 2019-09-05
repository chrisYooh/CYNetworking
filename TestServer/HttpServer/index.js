/* ID = In Docker */

var url = require('url');
var express = require('express');
var bodyParser = require('body-parser');
var multer = require('multer');

var app = express();
app.use(express.static('htmls'));
app.use(bodyParser.urlencoded({ extended: false }));

app.get("/getTest", function (req, res) {

    var host = server.address().host;
    var port = server.address().port;

    /* 参数获取 */
    var paras = url.parse(req.url, true).query;
    console.log(paras)

    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    res.write("Get Test: http:" + host + ":" + port + "\n");
    res.write(JSON.stringify(paras));
    res.end();
});

app.post("/postTest", function (req, res) {

    var host = server.address().host;
    var port = server.address().port;

    /* 参数获取 */
    var paras = url.parse(req.url, true).query;
    console.log(paras)

    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    res.write("Post Test:" + host + ":" + port + "\n");
    res.write(JSON.stringify(paras));
    res.end();
});

var server = app.listen(9999, function () {

    var host = server.address().host;
    var port = server.address().port;

    console.log("服务地址: http://%s:%s", host, port);
});

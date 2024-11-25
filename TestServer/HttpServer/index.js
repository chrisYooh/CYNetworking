/* ID = In Docker */

var url = require('url');
var express = require('express');
var bodyParser = require('body-parser');
var multer = require('multer');

var app = express();
app.use(express.static('htmls'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.text());
app.use(bodyParser.json());

app.get("/getTest", function (req, res) {

    var host = server.address().host;
    var port = server.address().port;

    /* 参数获取 */
    var paras = url.parse(req.url, true).query;
    console.log("GET Params: ", JSON.stringify(paras))

    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    res.write("Get Test: http:" + host + ":" + port + "\n");
    res.write(JSON.stringify(paras));
    res.end();
});

app.post("/postTest", function (req, res) {

    var host = server.address().host;
    var port = server.address().port;

    /* Query参数获取 */
    var paras = url.parse(req.url, true).query;
    console.log("POST Params: ", JSON.stringify(paras))

    /* Body参数获取 */
    console.log("POST Body: ", req.body)

    res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
    res.write("Post Test:" + host + ":" + port + "\n");
    res.write(JSON.stringify(paras));
    res.write(JSON.stringify(req.body));
    res.end();
});

var server = app.listen(9999, function () {

    var host = server.address().host;
    var port = server.address().port;

    console.log("服务地址: http://%s:%s", host, port);
});

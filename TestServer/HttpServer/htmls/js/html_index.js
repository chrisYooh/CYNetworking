
function onIdTest() {

    var reqStr = "serverInfo";

    $.get(reqStr, function (data, status) {
        $("#id_testLabel").text(data);
    }.bind(this));
}


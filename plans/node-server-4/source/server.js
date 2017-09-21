var http = require('http');
var port = 4004;

var handleRequest = function(request, response) {
    response.writeHead(200, {"Content-Type": "text/plain"});
    // response.end("I represent an older version");
    response.end("This server operates on node " + process.version + "\n");
}

var www = http.createServer(handleRequest);
www.listen(port, function() {
    console.log("Running on http://0.0.0.0:%d", port);
});



var http = require('http'),
	nconf = require('nconf');


//nconf.file({ file: '../config/config.json' });

//var port = nconf.get('port');
var port = parseInt(process.env.PORT) ;
var secret = process.env.SECRET;

var handleRequest = function(request, response) {
    response.writeHead(200, {"Content-Type": "text/plain"});
    // response.end("I represent an older version");
    response.end("I HAVE BEEN UPDATED. My magic value is: '" + secret + "'");
}

var www = http.createServer(handleRequest);
www.listen(port, function() {
    console.log("Running on http://0.0.0.0:%d", port);
});



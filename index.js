var express = require('express'),
    server  = express(),
    util    = require('util')

var PORT = 8080;

server.get('/', function (req, res) {
  res.send('Hello World\n');
});

server.listen(PORT)
util.log('Running on http://localhost:' + PORT);

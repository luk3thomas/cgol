
/**
 * Module dependencies.
 */

var express = require('express')
    , routes = require('./routes')
    , user = require('./routes/user')
    , http = require('http')
    , path = require('path');

var app = express()
    , server = http.createServer(app)
    , io = require('socket.io').listen(server);

// all environments
app.set('port', 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
app.use(require('less-middleware')(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/chat', routes.chat);
app.get('/users', user.list);

server.listen(app.get('port'), function(){
    console.log('Server listening on %d...', app.get('port'));
});

io.sockets.on('connection', function (socket) {
  socket.emit('chats', { message: 'Welcome to the chatroom!' });
  socket.on('chat', function (data) {
    io.sockets.emit('chats', { message: data });
  });
});

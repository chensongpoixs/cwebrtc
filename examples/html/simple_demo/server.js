var http=require("http");
var express=require("express");//引入express
var socketIo=require("socket.io");//引入socket.io
var app=new express();
var server=http.createServer(app);
var io= socketIo(server);//将socket.io注入express模块
//客户端 1 的访问地址
app.get("/webrtc",function (req,res,next) {
    res.sendFile(__dirname+"/webrtc/room.html");
});
//客户端 2 的访问地址
//app.get("/client2",function (req,res,next) {
//    res.sendFile(__dirname+"/views/client2.html");
//});
server.listen(8080);//express 监听 8080 端口，因为本机80端口已被暂用
//每个客户端socket连接时都会触发 connection 事件
//io.on("connection",function (clientSocket) {
//    // socket.io 使用 emit(eventname,data) 发送消息，使用on(eventname,callback)监听消息
//    //监听客户端发送的 sendMsg 事件
//    clientSocket.on("sendMsg",function (data) {
//        // data 为客户端发送的消息，可以是 字符串，json对象或buffer
//        // 使用 emit 发送消息，broadcast 表示 除自己以外的所有已连接的socket客户端。
//        clientSocket.broadcast.emit("receiveMsg",data);
//    })
//});

var log4js = require('log4js');


log4js.configure({
    appenders: {
        file: {
            type: 'file',
            filename: 'app.log',
            layout: {
                type: 'pattern',
                pattern: '%r %p - %m',
            }
        }
    },
    categories: {
       default: {
          appenders: ['file'],
          level: 'debug'
       }
    }
});
var USERCOUNT = 3;
var logger = log4js.getLogger();
io.on('connection', (socket)=> {

	socket.on('message', (room, data)=>{
		logger.debug('message, room: ' + room + ", data, type:" + data.type);
		socket.to(room).emit('message',room, data);
	});

	/*
	socket.on('message', (room)=>{
		logger.debug('message, room: ' + room );
		socket.to(room).emit('message',room);
	});
	*/

	socket.on('join', (room)=>{
		socket.join(room);
		var myRoom = io.sockets.adapter.rooms[room]; 
		var users = (myRoom)? Object.keys(myRoom.sockets).length : 0;
		logger.debug('the user number of room (' + room + ') is: ' + users);

		if(users < USERCOUNT){
			socket.emit('joined', room, socket.id); //发给除自己之外的房间内的所有人
			//if(users > 1){
				socket.to(room).emit('other_join', room, socket.id);
				logger.debug('the -----> user number of room (' + room + ') is: ' + users);
			//}
		
		}else{
			socket.leave(room);	
			socket.emit('full', room, socket.id);
		}
		//socket.emit('joined', room, socket.id); //发给自己
		//socket.emit('joined', room, socket.id); //发给自己
		//socket.broadcast.emit('joined', room, socket.id); //发给除自己之外的这个节点上的所有人
		//socket.to(room).emit('other_join', room, socket.id);
		//io.in(room).emit('joined', room, socket.id); //发给房间内的所有人
	});

	socket.on('leave', (room)=>{

		socket.leave(room);

		var myRoom = io.sockets.adapter.rooms[room]; 
		var users = (myRoom)? Object.keys(myRoom.sockets).length : 0;
		logger.debug('the user number of room is: ' + users);

		//socket.emit('leaved', room, socket.id);
		//socket.broadcast.emit('leaved', room, socket.id);
		socket.to(room).emit('bye', room, socket.id);
		socket.emit('leaved', room, socket.id);
		//io.in(room).emit('leaved', room, socket.id);
	});

});
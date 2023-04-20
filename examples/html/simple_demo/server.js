var https=require("https");
var express=require("express");//引入express
var socketIo=require("socket.io");//引入socket.io
var serveIndex = require('serve-index'); // 目录导入
var fs = require('fs');



var app=new express();


var options = {
	key : fs.readFileSync('./certs/privkey.pem'),
	cert: fs.readFileSync('./certs/fullchain.pem')
}

var server=https.createServer(options, app);
var io= socketIo(server);//将socket.io注入express模块

app.use(serveIndex('./webrtc'));
app.use(express.static('./webrtc'));

 
app.get("/webrtc",function (req,res,next) {
    res.sendFile(__dirname+"/webrtc/room.html");
});
 
server.listen(8088);//express 监听 8080 端口，因为本机80端口已被暂用
 

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
//  房间的人数的设置哈
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
			//if(users >= 1)
			{
				socket.to(room).emit('other_join', room, socket.id);
				logger.debug('the -----> user number of room (' + room + ') is: ' + users);
			}
		
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
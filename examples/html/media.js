// create date : 2022-03-22

// 如果遍历设备失败, 则回调该函数
function handleError(error)
{
	console.log('err:', error);
}


//采集到某路流
function gotMediaStream(stream)
{
	
	
}

// 从设备选项栏里选择某个设备
var deviceId = ''; 

// 设置采集限制
var constraints = {
	video : {
		width : 640,
		height : 480,
		frameRate: 15,
		facingMode : 'enviroment',
		deviceId : deviceId?{exact:deviceId}: undefined
	},
	audio : false
	
	
}
console.log(constraints);
//开始采集数据 ^_^ 
navigator.mediaDevices.getUserMedia(constraints)
					.then(gotMediaStream)
					.catch(handleError);
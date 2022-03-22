
//从H5获取<video> 标签
const lv = document.querySelector('video');
// 如果遍历设备失败, 则回调该函数
function handleError(error)
{
	console.log('err:', error);
}


// getUserMedia的采集限制
const contrains = {
	video : true,
	audio : true
};

//调用getUserMedia成功后， 回调该函数
function gotLocalStream(mediaStream)
{
	lv.srcObject  = mediaStream;
	
}

navigator.mediaDevices.getUserMedia(contrains)
				.then(gotLocalStream)
				.catch(handleError);
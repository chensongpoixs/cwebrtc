// create date : 2022-03-22

// 如果遍历设备失败, 则回调该函数
function handleError(error)
{
	console.log('err:', error);
}

// 如果得到音视频设备,则回调该函数
function gotDevices(deviceinfos)
{
	// 遍历所有设备信息
	for (let i = 0; i !== deviceinfos.length; ++i)
	{
		// 取每个设备信息
		const deviceinfo = deviceinfos[i];
		console.log(deviceinfo);
	}
}

// 遍历所有音视频设备哈 ^_^ 
navigator.mediaDevices.enumerateDevices().then(gotDevices).catch(handleError);
## usage : printSteererVsTimes(timeLine, steererMat, steererNames)
##
## ステアラの補正値（逆極性を入力すること）を入力しやすいように、
## 時間軸に沿って出力

function printSteererVsTimes(timeLine, steererMat, steererNames)
	for i = 1:length(steererNames)
		steererNames{i}
		[timeLine,steererMat(:,i)]
	endfor
endfunction
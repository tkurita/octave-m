## usage : printSteererVsTimes(timeLine, steererMat, steererNames)
##
## �X�e�A���̕␳�l�i�t�ɐ�����͂��邱�Ɓj����͂��₷���悤�ɁA
## ���Ԏ��ɉ����ďo��

function printSteererVsTimes(timeLine, steererMat, steererNames)
	for i = 1:length(steererNames)
		steererNames{i}
		[timeLine,steererMat(:,i)]
	endfor
endfunction
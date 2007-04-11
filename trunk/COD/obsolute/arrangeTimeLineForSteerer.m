## usage : steererTimeLine = arrangeTimeLineForSteerer(codRecordList, targetSteerer)
## 
## targetSteerer の補正値の時間変化を出力する。
##
##= Parameters
## * codRecordList は 以下の filed を持った構造体の cell array
##   * codRecord
##       .steererNames
##       .steererValues
##       .time
## * targetSteerer
##     .steererNames に含まれているステアラの名前。

function steererTimeLine = arrangeTimeLineForSteerer(codRecordList, targetSteerer)
	times = [];
	steererValues = [];
#	targetSteerer = "SH2";
	for i = 1:length(codRecordList)
#		i = 1;
		codRec = codRecordList{i};
		steererNames = codRec.steererNames;
		for j = 1:length(steererNames)
			indSteerer = 0;
			if (strcmp(steererNames(j), targetSteerer))
				indSteerer = j;
				break;
			endif
		endfor
		
		
		steererValues = [steererValues; codRec.steererValues(indSteerer)];
		times = [times; codRec.time];
	endfor
	
	steererTimeLine = [times, steererValues];
endfunction
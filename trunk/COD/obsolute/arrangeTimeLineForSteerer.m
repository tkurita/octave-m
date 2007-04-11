## usage : steererTimeLine = arrangeTimeLineForSteerer(codRecordList, targetSteerer)
## 
## targetSteerer �̕␳�l�̎��ԕω����o�͂���B
##
##= Parameters
## * codRecordList �� �ȉ��� filed ���������\���̂� cell array
##   * codRecord
##       .steererNames
##       .steererValues
##       .time
## * targetSteerer
##     .steererNames �Ɋ܂܂�Ă���X�e�A���̖��O�B

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
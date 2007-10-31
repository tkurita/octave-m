## usage : bLine = BValuesAtTimes(BPattern, tLine)

function bLine = BValuesAtTimes(BPattern, tLine)
	bLine = [];
	for i = 1:length(tLine)
		bLine = [bLine; BValueAtTime(BPattern, tLine(i))];
	endfor
endfunction
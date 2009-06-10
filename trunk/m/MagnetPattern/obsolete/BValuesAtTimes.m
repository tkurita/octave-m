## usage : bLine = BValuesAtTimes(BPattern, tLine)

function bLine = BValuesAtTimes(BPattern, tLine)
  warning("BValuesAtTimes is obsolete. use value_at_time.");
	bLine = [];
	for i = 1:length(tLine)
		bLine = [bLine; BValueAtTime(BPattern, tLine(i))];
	endfor
endfunction
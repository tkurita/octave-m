## usage : codRecord = setTime(codRecord, t)
##
## change "time" field of codRecord into t

function result = setTime(codRecord, t)
	result = codRecord;
	result.time = t;
endfunction

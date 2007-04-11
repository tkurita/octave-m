## usage : brho = BrhoAtTime(blPattern,t)
##
## = Parameters
## * blPattern
## * t -- time [msec] or a structure which have 'time' field.
##
## = Result
## brho -- [T*m]

function brho = BrhoAtTime(blPattern,t)
  if (isstruct(t))
    if (isfield(t, "time"))
      t = t.time;
    else
      error ("The structure of second argument must have 'time' field");
    endif
  endif
  
  bl = BValueAtTime(blPattern,t);
  ## BL �ς��o�˃G�l���M�[�� Brho �ƈ�v���Ȃ��̂ŁA
  ## ��v�����邽�߂ɁAfactor 1.0.1 �Ŋ���B
  brho = bl/(pi/4)/1.01; 
endfunction
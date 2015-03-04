## -*- texinfo -*-
## @deftypefn {Function File} {@var{shited_harmonics_ctrlv} =} shift_harmonics_time(@var{harmonics_ctrlv}, @var{msec})
##
## @end deftypefn

function hctrlv = shift_harmonics_time(hctrlv, msec)
  sidx = find(hctrlv.msecList == msec);
  names = fieldnames(hctrlv);
  for n = 1:length(names)
    hctrlv.(names{n}) = hctrlv.(names{n})(sidx:end);
  endfor
  hctrlv.msecList -= msec;
endfunction


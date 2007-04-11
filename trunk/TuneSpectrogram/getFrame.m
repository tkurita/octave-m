## = Parameters
## * frame_number -- 1 based frame number to get

function [result] = getFrame(sGramRec_in, frame_number, xname)
  x = sGramRec_in.(xname);
  y = sGramRec_in.dBm(frame_number, :);
  result = [x(:), y(:)];
endfunction
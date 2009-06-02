## = Parameters
## * frame_number -- 1 based frame number to get

##== History
## 2009-06-02
## * Renamed from getFrame

function [result] = frame_spectrum_at(specdata, frame_number, xname)
  x = specdata.(xname);
  y = specdata.dBm(frame_number, :);
  result = [x(:), y(:)];
endfunction
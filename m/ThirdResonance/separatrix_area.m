## Usage : area = separatrix_area(track_rec)
##
##== Parameters
## * track_rec
##  .sextupoles
##    .strength
##  .lattice
##  .tune
##
##== Result
## [pi mrad mm]

##== History
## 2014-10-02
## * if nargout == 0, print the formatted result.
## 2008-02-09
## * use values_for_separatrix instead of prepare_for_separatrix
## 2007-10-12
## * initial implementaion

function varargout = separatrix_area(track_rec)
  sep_info = values_for_separatrix(track_rec);
  sep_area = 2/sqrt(3)*(sep_info.delta_tune/sep_info.a_3n0)^2*1e6/pi;
  if nargout 
    varargout{1} = sep_area;
  else
    printf("%f [pi mrad mm]\n", sep_area);
  endif
endfunction

  

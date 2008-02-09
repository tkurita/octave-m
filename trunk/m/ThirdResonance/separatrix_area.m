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
## 2007-10-12
## * initial implementaion

function area = separatrix_area(track_rec)
  sep_info = values_for_separatrix(track_rec);
  area = 2/sqrt(3)*(sep_info.delta_tune/sep_info.a_3n0)^2*1e6/pi;
endfunction

  

## -*- texinfo -*-
## @deftypefn {Function File} {@var{kickers} =} kickers_with_cod_rec(@var{lattice_rec}, @var{cod_rec1}, @var{cod_rec2}, ...)
##
## Make a cell array of kicker structures from cod_recs
## kicker array is passed to track_rec passed to run_tracking
##
## @var{cod_rec} must have following fields.
##
## @table @code
## @item steererNames
## @item kickAngles
## @item kickFactor
## @item brho
## @end table
##
## @end deftypefn

##== History
## 2007-10-03
## * initial implementaion

function kickers = kickers_with_cod_rec(varargin)
  lattice_rec = varargin{1};
  kickers = {};
  for n = 2:length(varargin)
    cod_rec = varargin{n};
    if (isfield(cod_rec, "kickFactor"))
      cod_rec.kickAngles = cod_rec.kickAngles*cod_rec.kickFactor;
    endif
    
    for m = 1:length(cod_rec.steererNames)
      cod_rec.lattice = lattice_rec.lattice;
      kickers{end+1} = kicker_with_angle(cod_rec.steererNames{m}...
        , cod_rec.kickAngles(m), cod_rec);
    endfor
  endfor
endfunction

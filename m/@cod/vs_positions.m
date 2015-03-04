## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} vs_positions(@var{cod})
## obtain COD vs positions in the ring.
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
## 
## @seealso{}
## @end deftypefn

##== History
## 2013-11-26
## * first implementation

function cod_list = vs_positions(in)
  a_lattice = in.ring.lattice;
  cod_at_bpm = in.at_bpms;
  x = []; # COD
  s = []; # position
  for n = 1:length(a_lattice)
    latticeElement = a_lattice{n};
    elementName = latticeElement.name;
    if (isfield(cod_at_bpm, elementName))
      x = [x; cod_at_bpm.(elementName)];
      s = [s; latticeElement.centerPosition];
    endif
  endfor
  cod_list = [s,x];
endfunction
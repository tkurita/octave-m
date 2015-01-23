## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} momentum_compaction_factor(@var{lattice})
## Obtain momentum compaction factor.
## @strong{Inputs}
## @table @var
## @item lattice
## a cell array of elements or a sturct which have allElements field.
## dispersion values of all elements should be prepared.
## @end table
## 
## @seealso(calc_lattice)
## @end deftypefn

##== History
## 2015-01-23
## * append texinfo help.
## 2008-04-30
## * renamed from momentumCompactionFactor
## * Use is_BM intead of isBendingMagnet

function alpha = momentum_compaction_factor(lattice)
  if nargin < 1
    print_usage(); return;
  endif
  if isstruct(lattice)
    lattice = lattice.allElements;
  endif
  alpha = 0;
  for n = 1:length(lattice)
    an_elem = lattice{n};
    
    if (is_BM(an_elem))
      eater = (lattice{n-1}.eater(1)+an_elem.eater(1))/2;
      alpha += eater*an_elem.bmangle;
    endif
  end
  
  #C = 33.201; #peripheral length [m]
  C = circumference(lattice);
  alpha /= C;
endfunction


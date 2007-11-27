## @deftypefn {Function File} {} QF(@var{property_struct})
## @deftypefnx {Function File} {} QF(@var{qk}, @var{ql}, @var{name} [,@var{aparture}] )
##
## Make QF magnet object
##
## @end deftypefn

##== History
## 2007-11-24
## * accept a structure as an argument.

#function q_struct = QF(qk, ql, a_name, varargin)
function q_struct = QF(varargin)
  if (length(varargin) == 1)
    if (isstruct(varargin{1}))
      q_struct = varargin{1};
    else
      error("invalid argument");
    endif
  else
    qk = varargin{1};
    ql = varargin{2};
    a_name = varargin{3};
    
    if (isstruct(ql))
      q_struct = ql;
    else
      q_struct.len = ql;
    endif
    q_struct.name = a_name;
    q_struct.k = qk;
    
    if (length(varargin) > 3)
      q_struct.duct = duct_aperture(varargin{4});
    endif
    
  endif
  
  ##== horizontal
  q_struct = setup_element(q_struct, @QFmat, "h");
  
  ##== vertical
  q_struct = setup_element(q_struct, @QDmat, "v");  
  
  q_struct.kind = "QF";
endfunction
## @deftypefn {Function File} {} QD(@var{property_struct})
## @deftypefnx {Function File} {} QD(@var{qk}, @var{ql}, @var{name} [,@var{aparture}] )
##
## Make QD magnet object
##
## @end deftypefn

##== History
## 2007-11-24
## * accept a structure as an argument.

#function q_struct = QD(qk, ql, theName, varargin)
function q_struct = QD(varargin)
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
    
    if (length(varargin) > 4)
      q_struct.duct = ductAperture(varargin{4});
    endif
    
  endif

  ##== horizontal
  q_struct = setup_element(q_struct, @QDmat, "h");
  
  ##== vertical
  q_struct = setup_element(q_struct, @QFmat, "v");  
  
  if (length(varargin) != 0)
    q_struct.duct = ductAperture(varargin{1});
  endif
  q_struct.kind = "QD";
endfunction
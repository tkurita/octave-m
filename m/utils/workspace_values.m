## -- [var1,...] = workspace_values("varnam1", ...)
##     Obtain variables defined in worskpace.
##     Use in functions defined in top level of the workspace
##     to rever variables in the workspace.
##
##  * Inputs *
##    names of variabels
##
##  * Outputs *
##    values of variables.
##    if outputs are omitte, variabels are defined in the caller context.
##    
##  * Exmaple *
##    v1 = 100;
##    v2 = {1, 2};
##    function testfunc()
##      workspace_values("v1", "v2");
##      v1, v2
##    endfunction
##
##  See also: 

function varargout = workspace_values(varargin)
  if ! nargin
    print_usage();
    return;
  endif

  for n = 1:length(varargin)
    varargout{n} = evalin("base", varargin{n});
  endfor
  if nargout == 0
    for n = 1:length(varargin)
      assignin("caller", varargin{n}, varargout{n});
    endfor
  endif
endfunction

%!test
%! func_name(x)

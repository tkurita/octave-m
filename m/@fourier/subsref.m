## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@arg{obj}, @var{idx})
## 
## ## @table @code
## @item fdBm
## @item fdB
## @item xy
## @item amp
## @item amplitude
## @item phase
## @item freq
## @end table
##
## @end deftypefn

##== History
## 2015-02-05
## * added "amp", "amplitude", "phase", "freq"
## 2015-02-04
## * subscription "xy" returns [frequency, amplitude]. 
##   amplituede is not passed through log10.
## 2014-12-23
## * added "fdB".
## 2014-11-17
## * first implementation

function retval = subsref(x, s)
  if (isempty(s))
    error("missing index");
  endif

  switch s(1).type
    case "()"
    case "{}"
    case "."
      fld = s.subs;
      switch fld
        case "fdBm"
          retval = [x.frequency(:), 10*log10((amp(x).^2./2)./50*1e3)(:)];
        case "fdB"
          retval = [x.frequency(:), 20*log10(amp(x))(:)];
        case "xy"
          retval = [x.frequency(:), amp(x)(:)];
        case {"amp", "amplitude"}
            retval = amp(x); 
        case "phase"
            retval = phase(x);
        case "freq"
            retval = x.frequency;
        otherwise
          retval = x.(fld);
        endswitch
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction

%!test
%! func_name(x)

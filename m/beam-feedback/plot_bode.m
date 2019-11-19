## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} plot_bode(@var{arg})
## description
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
## @end deftypefn

##== History
## 2011-07-22
## * first argument can have properties for plot command.

function retval = plot_bode(plargs, varargin)

opts = get_properties(varargin...
  , {"xlim", "title"}, {NA, NA});

margs = {};
for n = 1:2:length(plargs)
  if ischar(plargs{n})
    margs{end+1} = plargs{n};
    margs{end+1} = plargs{n+1};
  else
    margs{end+1} = plargs{n}.w_norm;
    margs{end+1} = 20*log10(plargs{n}.mag);
    margs{end+1} = plargs{n+1};
  endif
endfor

pargs = {};
for n = 1:2:length(plargs)
  if ischar(plargs{n})
    pargs{end+1} = plargs{n};
    pargs{end+1} = plargs{n+1};
  else
    pargs{end+1} = plargs{n}.w_norm;
    pargs{end+1} = plargs{n}.phase;
    pargs{end+1} = plargs{n+1};
  endif
endfor

clf;
subplot(2,1,1);
plot(margs{:}); set(gca, "xscale", "log"); grid on;
ylabel("gain [dB]");
if !isna(opts.xlim) 
  xlim(opts.xlim);
endif
if ischar(opts.title) 
  title(opts.title);
endif
subplot(2,1,2)
plot(pargs{:}); set(gca, "xscale", "log"); grid on;
ylabel("phase [degree]"); xlabel("\\omega /\\omega_s");
if !isna(opts.xlim) 
  xlim(opts.xlim);
endif

endfunction

%!test
%! plot_bode(x)

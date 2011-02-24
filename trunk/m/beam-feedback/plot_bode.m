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
##

function retval = plot_bode(plargs, varargin)

opts = get_properties(varargin...
  , {"xlim", "title"}, {NA, NA});

margs = {};
for n = 1:2:length(plargs)
  margs{end+1} = plargs{n}.w_norm;
  margs{end+1} = 20*log(plargs{n}.mag);
  margs{end+1} = plargs{n+1};
endfor

pargs = {};
for n = 1:2:length(plargs)
  pargs{end+1} = plargs{n}.w_norm;
  pargs{end+1} = plargs{n}.phase;
  pargs{end+1} = plargs{n+1};
endfor

clf;
subplot(2,1,1);
plot(margs{:}); set(gca, "xscale", "log"); grid on;
ylabel("gain [dB]");
if !isna(opts.xlim) 
  xlim(opts.xlim);
endif
if !isna(opts.title) 
  title(opts.title);
endif
subplot(2,1,2)
plot(pargs{:}); set(gca, "xscale", "log"); grid on;
ylabel("phase [degree]"); xlabel("{/Symbol w}/{/Symbol w}_s");
if !isna(opts.xlim) 
  xlim(opts.xlim);
endif

endfunction

%!test
%! plot_bode(x)

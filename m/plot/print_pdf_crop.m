## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} print_pdf_crop(@var{pdffile})
## output PDF file and crop it.
## @strong{Inputs}
## @table @var
## @item pdffile
## output PDF file path.
## @end table
##
## @seealso{pdfcrop}
## @end deftypefn

##== History
## 2014-04-09
## first implementation

function print_pdf_crop(pdffile, varargin)
  if ! nargin
    print_usage();
  endif
  opts = get_properties(varargin,...
                {"margins"}, {"10 10 10 10"});
  print("-dpdf", pdffile);
  opts_cell = {};
  for [val, key] = opts
    opts_cell{end+1} = key;
    opts_cell{end+1} = val;
  endfor
  pdfcrop(pdffile, opts_cell{:});
endfunction

%!test
%! func_name(x)

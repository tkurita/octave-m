## -*- texinfo -*-
## @deftypefn {Function File} {} pdfcrop(@var{pdffile})
## Crop pdf file. The source file will be replace with the cropped file.
## @strong{Inputs}
## @table @var
## @item pdffile
## A source PDF file
## @end table
##
## @seealso{print_pdf_crop}
## @end deftypefn

##== History
## 2014-04-09
## first implementation

function retval = pdfcrop(pdffile, varargin)
  if ! nargin
    print_usage();
  endif
  opts = get_properties(varargin,
                            {"margins"}, {"0 0 0 0"});
  s = stat(pdffile);
  if !length(s)
    error(sprintf("Can't find '%s' .", pdffile));
  endif
  
  pdfcrop_path = file_in_path(getenv("PATH"), "pdfcrop");
  [d, name, ext, v] = fileparts(pdffile);
  new_pdf = fullfile(d, [name,"-crop", ext]);
  [err, msg] = system(sprintf("%s --margins '%s' '%s' '%s'",...
               pdfcrop_path, opts.margins, pdffile, new_pdf));
  if err != 0
    error(sprintf("Failed to pdfcrop error %d : %s", err, msg));
  endif
  
  [err, msg] = unlink(pdffile);
  if err !=0
    error(sprintf("Failed to unlink %s with error %d : %s",...
                       pdffile, err, msg));
  endif
  
  [err, msg] = rename(new_pdf, pdffile);
  if err != 0
    error(sprintf("Failed to rename '%s' to '%s' with error %d : %s",...
          new_pdf, pdffile, err, msg));
  endif
endfunction

%!test
%! func_name(x)

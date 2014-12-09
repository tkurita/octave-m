## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} isf_data(@var{filename})
## Parse .isf format file of tektronics oscilloscopes.
##
## @example
## isf = isf_data(path_to_file);
## isf.v # voltage data
## isf.ts # sampling interval in sec
## xy(isfdata) # obtain voltage vs time
## zc_frequency(isdata);
## @end example
##
## @strong{Inputs}
## @table @var
## @item filename
## path to the .isf file
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## isf_data object
## @end table
## 
## @end deftypefn

##== History
## 2014-12-08
## * use struct instead of dict.
## 2014-12-01
## * fixed : misread total byte in some cases.
## 2014-11-11
## * added "pkg load struct".
## 2014-07-01
## * support isf of TDS3000
## 2012-10-16
## * first implementation

function retval = isf_data(varargin)
  if ! nargin
    print_usage();
  endif

  if isstruct(varargin{1})
    retval = class(varargin{1}, "isf_data");
    return
  else
    filename = varargin{1};
  endif
  pkg load struct;

  fid = fopen(filename, "r");
  preambles = struct;
  buff = "";
  frewind(fid);
  while(1)
    s = fgets(fid, 1);
    switch s
      case ";"
           sep_ind = index(buff, " ");
           field_name = substr(buff, 1, sep_ind-1);
           field_value = substr(buff, sep_ind+1);
           preambles.(field_name) = field_value;
           buff = "";
      case "#"
           break;
      otherwise
         buff = [buff, s];
    endswitch
  endwhile
  [c, msg] = fscanf(fid, "%1s", 1);
  [totalbyte, msg] = fscanf(fid, ["%", c, "d"], 1);
  byte_per_point = str2num(find_field(preambles, {":WFMP:BYT_N", ":WFMPRE:BYT_NR"}));
  totalpoints = totalbyte/byte_per_point;
  y = fread(fid, totalpoints, sprintf("%d*int16", totalpoints), "ieee-be");
  fclose(fid);
  ymulti = str2num(find_field(preambles, {"YMU", "YMULT"}));
  yoffset = str2num(find_field(preambles, {"YOF", "YOFF"}));
  yzero = str2num(find_field(preambles, {"YZE", "YZERO"}));

  retval.v = (y - yoffset)*ymulti +yzero;
  retval = setfields(retval, "preambles", preambles,...
                             "totalpoints", totalpoints);
  retval = class(retval, "isf_data");
endfunction

function retval = find_field(s, keys)
  for k = keys
    if isfield(s, k{:})
      retval = s.(k{:});
      return;
    endif
  endfor
endfunction

%!test
%! func_name(x)

## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} isf_data(@var{filename})
## Parse .isf format file of tektronics oscilloscopes.
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
## @deftypefnx {Accessor method} isfdata.xy
## Return list of xy values.
## 
## @end deftypefn

##== History
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
  pkg load general;
  fid = fopen(filename, "r");
  preambles = dict;
  buff = "";
  frewind(fid);
  while(1)
    s = fgets(fid, 1);
    switch s
      case ";"
           sep_ind = index(buff, " ");
           field_name = substr(buff, 1, sep_ind-1);
           field_value = substr(buff, sep_ind+1);
           preambles(field_name) = field_value;
           buff = "";
      case "#"
           break;
      otherwise
         buff = [buff, s];
    endswitch
  endwhile
  
  [totalbyte, c, msg] = fscanf(fid, "%1d%d", 2);
  totalbyte = totalbyte(2);
  byte_per_point = str2num(preambles(":WFMP:BYT_N"));
  totalpoints = totalbyte/byte_per_point;
  y =fread(fid, totalpoints, sprintf("%d*int16", totalpoints), "ieee-be");
  fclose(fid);
  ymulti = str2num(preambles("YMU"));
  yoffset = str2num(preambles("YOF"));
  yzero = str2num(preambles("YZE"));

  retval.v = (y - yoffset)*ymulti +yzero;
  retval = setfields(retval, "preambles", preambles,...
                             "totalpoints", totalpoints);
  retval = class(retval, "isf_data");
endfunction

%!test
%! func_name(x)

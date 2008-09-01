## -*- texinfo -*-
## @deftypefn {Function File} {} represent_cod(@var{args})
## 
## Sum COD list and shift it to match same COD at the specified location according as dispersion.
##
## @example
## represent_cod("lattice", lattice);
## represent_cod("Base BPM", "BPM7"); # optional, default is "BPM7"
## represent_cod("target BPMs", bpm_struct);
## [total_cod, p_error] = represent_cod(cod_list1, cod_list2, ....);
## @end example
##
## @seealso{shift_cod_with_perror};
##
## @end deftypefn

##== History
## 2007-10-26
## * can return p_error

function varargout = represent_cod(varargin)
  persistent target_bpms;
  persistent a_lattice;
  persistent base_bpm = "BPM7";
  
  if (ischar(varargin{1}))
    if (strcmp("target BPMs", varargin{1}))
      target_bpms = varargin{2};
    elseif (strcmp("lattice", varargin{1}))
      a_lattice = varargin{2};
    elseif (strcmp("Base BPM", varargin{1}))
      base_bpm = varargin{2};
    endif
    return;
  endif
  
  if length(a_lattice) < 1
    error("lattice is not given.")
  endif
  
  if length(target_bpms) < 1
    error("target_bpms is not given.")
  endif
  
  cod_sum = sum_y(varargin{:});
  bpm_sum = lookup_cod_at_elements(cod_sum, a_lattice, base_bpm);
  bpm_diff = target_bpms.(base_bpm) - bpm_sum;
  expected_perror = bpm_diff/element_with_name(a_lattice, base_bpm).centerDispersion/1000;
  varargout{1} = shift_cod_with_perror(cod_sum, a_lattice, expected_perror);
  if (nargout > 1)
    varargout{2} = expected_perror;
  endif
endfunction
      
## -*- texinfo -*-
## @deftypefn {Function File} {} print_with_keypath(@var{struct_array}, @var{key_path1}, ...)
## 
##
## @end deftypefn

function print_with_keypath(struct_array, varargin)
  # struct_array = track_rec.lattice
  # varargin  = {"name", "entrancePosition"}
  val_array = {};
  for n = 1:length(varargin)
    val_array = [val_array; value_for_keypath(struct_array, varargin{n}, "as_cells")];
  endfor
  
  title_row = varargin{1};
  for n = 2:length(varargin)
    title_row = [title_row, "\t", varargin{n}];
  endfor
  
  printf("%s\n", title_row);
  
  p_format = "";
  for n = 1:length(varargin)
    if (ischar(val_array{n,1}))
      p_format = [p_format, "%s\t"];
    else
      p_format = [p_format, "%g\t"];
    endif
  endfor
  
  p_format = [p_format(1:end-1), "\n"];
  
  for n = 1:columns(val_array)
    printf(p_format, val_array{:,n});
  endfor
endfunction
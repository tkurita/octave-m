## Usage : result = load_profile_csv(file_path)
##      load "Hold" data of profile monitors.
##
## = Parameters
## * file_path -- a path to the file.
##
## = Result
## a structue which have following fields
##  .h -- [positions, values]
##  .v -- [positions, values]

##== History
## 2008.01.09
## * renamed from loadProfileCVS

function result = load_profile_csv(file_path)
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  for n = 1:2 # skip two lines
    fgetl(fid);
  endfor
  
  positions = __read_line_mat__(fid);
  values = __read_line_mat__(fid);
  result.h = [positions(:), values(:)];
  
  positions = __read_line_mat__(fid);
  values = __read_line_mat__(fid);
  result.v = [positions(:), values(:)];
  
  fclose(fid);
endfunction

function mat = __read_line_mat__(fid)
  cells = csvexplode(deblank(fgetl(fid)));
  cells = cells(2:end);
  mat = cell2mat(cells);
endfunction

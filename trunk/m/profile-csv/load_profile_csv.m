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
##  .name
##  .time

##== History
## 2008-08-07
## * add fields 'name' and 'time' into the result
## 2008.01.09
## * renamed from loadProfileCVS

function result = load_profile_csv(file_path)
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  aline = deblank(fgetl(fid));
  [S, E, TE, M, T, NM] = regexp(aline, "(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+");
  dvec = map(@str2num, T{1});
  result.time = cell2mat(dvec);
  
  aline = deblank(fgetl(fid));
  [S, E, TE, M, T, NM] = regexp(aline, "ÅF(.+)$");
  result.name = T{1}{1};
  
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

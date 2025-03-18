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
## 2013-06-14
## * use cellfun instead of map.
## * load "io"
## 2008-08-07
## * add fields 'name' and 'time' into the result
## 2008.01.09
## * renamed from loadProfileCVS

function result = load_profile_csv(file_path)
  pkg load "io";
  #file_path = "../0712/profile_data/SYN0712-190132.csv"
  #[fid, msg] = fopen(file_path, "r", "n", "Shift-JIS");
  [fid, msg] = fopen(file_path, "r");
  if (fid == -1)
    error(msg);
  endif
  
  aline = native2unicode(uint8(deblank(fgetl(fid))), "Shift-JIS");
  [S, E, TE, M, T, NM] = regexp(aline,
                                "(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+(\\d+)\\D+");
  result.time = cellfun(@str2num, T{1});
  
  aline = native2unicode(uint8(deblank(fgetl(fid))), "Shift-JIS");
  [S, E, TE, M, T, NM] = regexp(aline, "：(.+)$");
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

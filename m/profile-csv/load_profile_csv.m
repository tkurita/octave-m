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
## 2026-05-29
## * add: flags row support
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
  vals = __read_line_mat__(fid);
  aline = fgetl(fid);
  if ! startsWith(aline, "Y");
    flags = __parse_flags__(aline)
    vals = __apply_flags__(vals, flags);
    aline = fgetl(fid);
  endif
  result.h = [positions(:), vals(:)];

  positions = __parse_line_mat__(aline);
  vals = __read_line_mat__(fid);
  aline = fgetl(fid);
  if aline != -1
    flags = __parse_flags__(aline);
    vals = __apply_flags__(vals, flags);
  endif
  result.v = [positions(:), vals(:)];
  fclose(fid);
endfunction

function vals = __apply_flags__(vals, flags)
    lf = length(flags);
    lv = length(vals);
    if lf == lv
      # pass
    elseif lf > lv
      flgas = flags(1:length(vals));
    elseif lf < lv
      flgas(lf+1:lv) = ones(1, lv - lf);
    endif
    flags(flags==0) = nan;
    vals = vals .* flags;
endfunction

function mat = __parse_flags__(aline)
  cells = csvexplode(deblank(aline));
  for n = 1:length(cells)
    s = cells{n};
    if length(s) > 0
      if all(isspace(s))
        cells{n} = 1;
      endif
    else
      cells{n} = 1;
    endif
  endfor
  cells = cells(2:end);
  mat = cell2mat(cells);  
endfunction

function mat = __parse_line_mat__(aline)
  cells = csvexplode(deblank(aline));
  cells = cells(2:end);
  mat = cell2mat(cells);
endfunction

function mat = __read_line_mat__(fid)
  aline = fgetl(fid);
  mat = __parse_line_mat__(aline);
endfunction

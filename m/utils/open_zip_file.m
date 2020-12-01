## -- retval = open_zip_file(filepath)
##  load_osc_csv で使用されていた内部関数 _open_file を独立された。
##  あれば、filepath.zip を unzip しながら開く。
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function [fid, msg] = open_zip_file(filepath)
  zipfilename = find_zipfile(filepath);
  msg = "sucess to open file";
  if isempty(zipfilename)
    [fid, msg] = fopen(filepath, "r");
  else
    fid = popen(sprintf("unzip -p '%s' '%s'" ...
                ,zipfilename, basename(zipfilename, "\.zip")), "r");
    if (fid == -1)
      msg = "Faild to popen for unzip";
    endif
  endif
endfunction

function zipfilename = find_zipfile(filename)
  zipfilename = [];
  if !exist(filename, "file")
    zipfilename = [filename, ".zip"];
    if !exist(zipfilename, "file");
      error(["Can't find a file : ", filename]);
    endif
  elseif !isempty(regexp(filename, "\.zip$"))
    zipfilename = filename;
  endif
endfunction


##== History
## 2009-06-25
## * use fileparts instead of exchangeSuffix
## * use .mat as octave's data file

function writeDataForFG(filename, data, varargin)
  #filename  = exchangeSuffix(filename, ".dat");
  [dirname, bname, suffix] = fileparts(filename);
  matfile = fullfile(dirname, [bname,".mat"]);
  save(matfile, "data");
  out_file = quote(fullfile(dirname, [bname, ".txt"]));
  in_file = quote(matfile);
  pscript = quote(file_in_loadpath("prepareForHPFG.pl"));
  system([pscript, " ", in_file, " > ", out_file]);
endfunction

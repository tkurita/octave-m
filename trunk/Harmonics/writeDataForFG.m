##
function writeDataForFG(filename, data, varargin)
  filename  = exchangeSuffix(filename, ".dat");
  save filename data;
  out_file = ["'", exchangeSuffix(filename, ".txt"), "'"];
  in_file = ["'", filename, "'"];
  pscript = ["'", file_in_loadpath("prepareForHPFG.pl"), "'"];
  system([pscript, " ", in_file, " > ", out_file]);
endfunction

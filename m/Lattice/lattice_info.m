## -*- texinfo -*-
## @deftypefn {Function File} {} lattice_info(@var{latobj})
##
## Return information for the lattice object @var{latobj}
## 
## @end deftypefn

##== History
## 2008-08-01
## * first implementaion

function varargout = lattice_info(latobj)
  tune_text = disp_tune(latobj.tune);
  newline = "\n";
  
  info_text = "";
  if (isfield(latobj, "qfk"))
    qfk_comment = sprintf("qfk:%g [1/(m*m)]", latobj.qfk);
    qdk_comment = sprintf("qdk:%g [1/(m*m)]", latobj.qdk);
    info_text = [qfk_comment, newline, qdk_comment, newline];
  endif
  
  
  alpha = momentum_compaction_factor(latobj.lattice);
  alpha_comment = sprintf("momentum compaction factor:%g",alpha);
  
  ## calc chromaticity
  chrom = chromaticity(latobj.lattice);
  chrom_h_comment = sprintf("horizontal chromaticity:%g",chrom.h);
  chrom_v_comment = sprintf("vertical chromaticity:%g",chrom.v);
  
  retval = [info_text ...
    , tune_text(1,:),newline ...
    , tune_text(2,:),newline ...
    , alpha_comment, newline ...
    , chrom_h_comment, newline ...
    , chrom_v_comment];
  
  if (nargout < 1)
    disp(retval);
  else
    varargout = {retval};
  endif
endfunction
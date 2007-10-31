## -*- texinfo -*-
## @deftypefn {Function File} {@var{delta_nu} =} delta_nu_with_chromaticity(@var{chrom_rec}, @var{p_error})
##
## Retune tune shift @var{delta_nu} with chromaticity @var{chrom_rec} and momentum error  @var{p_error}.
##
## @end deftypefn

##== History
## 2007-10-26
## * initial implementaion

function delta_nu = delta_nu_with_chromaticity(chrom_rec, p_error)
  delta_nu.h = chrom_rec.h * p_error;
  delta_nu.v = chrom_rec.v * p_error;
endfunction
#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.06-7 9MeV 入射 COD/BMPe/BMPe.m

function cod_rec = fit_cod_with_perror(cod_rec)
  # cod_rec = cod_rec_9201_base
  all_elements = cod_rec.lattice;
  
  ref_dispersions = [];
  ref_names = [];
  ref_cod = [];
  for n = 1:length(all_elements)
    an_element = all_elements{n};
    if (isfield(cod_rec.codAtBPM, an_element.name))
      ref_dispersions(end+1) = an_element.centerDispersion;
      ref_names{end+1} = an_element.name;
      ref_cod(end+1) = cod_rec.codAtBPM.(an_element.name);
    endif
  endfor
  ref_cod = ref_cod/1000;
  
  cod_rec.pError = sum(ref_cod.*ref_dispersions)/(sum(ref_dispersions.^2));
endfunction

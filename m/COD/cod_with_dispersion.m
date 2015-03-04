#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.06-7 9MeV 入射 COD/BMPe/BMPe.m

function cod_list = cod_with_dispersion(cod_rec)
   # cod_rec = cod_rec_9201_base
  dispersions_center = valuesForKey(cod_rec.lattice, {"centerDispersion"});
  dispersions_exit = valuesForKey(cod_rec.lattice, {"exitDispersion"});
  dispersions = reshape([dispersions_center; dispersions_exit]
    , 1, length(dispersions_center)+length(dispersions_exit));
  
  positions_center = valuesForKey(cod_rec.lattice, {"centerPosition"});
  positions_exit = valuesForKey(cod_rec.lattice, {"exitPosition"});
  positions = reshape([positions_center; positions_exit]
    , 1, length(positions_center)+length(positions_exit));
  
  cod_list = [positions', (dispersions*cod_rec.pError*1000)'];
endfunction

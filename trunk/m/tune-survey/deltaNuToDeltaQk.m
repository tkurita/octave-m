## usage : deltaQk = deltaNuToDeltaQk(deltaNu, qfBeta,qdBeta)
##
## deltaQK は qfk, qdk ともに、磁場の強さを強くした時に、正
## 

##== History
## 2007-12-05
## * deltaNu can accept both of row wise and column wise
##

function deltaQk = deltaNuToDeltaQk(deltaNu, qfBeta,qdBeta)
  deltaNu = deltaNu(:);
  nq = 4; #それぞれのQ magnet の数
  #qlength = 0.15; #[m];
  qlength = 0.21; #[m];
  #  beta_mat = [qfBeta.h, qdBeta.h;
  #  -qfBeta.v, -qdBeta.v];
  #  
  #  beta_mat = (nq/(4*pi)).*beta_mat;
  #  #deltaQk = abs((beta_mat\deltaNu)./qlength);
  #  deltaQk = -1*(beta_mat\deltaNu)./qlength;
  beta_mat = [qfBeta.h, -qdBeta.h;
            -qfBeta.v, qdBeta.v];
  
  beta_mat = (nq/(4*pi)).*beta_mat;
  deltaQk = (beta_mat\deltaNu)./qlength;
endfunction
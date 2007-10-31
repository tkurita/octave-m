function deltaGL = deltaNuToGL(deltaNu, qfBeta,qdBeta, brho)
  nq = 4; #それぞれのQ magnet の数
  beta_mat = [qfBeta.h, qdBeta.h;
			  -qfBeta.v, -qdBeta.v];

  beta_mat = (nq/4*pi).*beta_mat;
  deltaGL = beta_mat\deltaNu;
  deltaGL = deltaGL * brho;
endfunction
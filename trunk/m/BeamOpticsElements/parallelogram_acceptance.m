function a_para = parallelogram_acceptance(an_elem)
  a_para = an_elem.duct
  [a_para.xdash_max, a_para.xdash_min]...
      = angle_limit(a_para.xmax, a_para.xmin, an_elem.mat.h)
  [a_para.ydash_max, a_para.ydash_min]...
      = angle_limit(a_para.ymax, a_para.ymin, an_elem.mat.v)
endfunction

function [dash_max, dash_min] = angle_limit(a_max, a_min, a_mat)
  dash_max.l = (a_min - a_mat(1,1)*a_max)/a_mat(1,2);
  dash_max.h = (a_max - a_mat(1,1)*a_max)/a_mat(1,2);
  if (dash_max.h > 0)
    dash_max.h = 0;
  endif
  
  dash_min.h = (a_max - a_mat(1,1)*a_min)/a_mat(1,2);
  dash_min.l = (a_min - a_mat(1,1)*a_min)/a_mat(1,2);
  if (dash_min.l < 0)
    dash_min.l = 0;
  endif
endfunction
  
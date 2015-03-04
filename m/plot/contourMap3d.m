## usage : contourMap3d(x, y, z)
##
## a wrapper of gnuplot's pm3d
##
## = Parameters
## z is matrix
## x is vector or matrix
## y is vector or matrix

function contourMap3d(x, y, z)
  if (ismatrix (z))
    size_msg = ["contour: columns(z) must be the same as length(x) and\n" \
    "rows(z) must be the same as length(y),\n" \
    "or x, y, and z must be matrices with the same size"];
    if (isvector (x) && isvector (y))
      xlen = length (x);
      ylen = length (y);
      if (xlen == columns (z) && ylen == rows (z))
        if (rows (x) == 1)
          x = x';
        endif
        len = 3 * ylen;
        zz = zeros (xlen, len);
        k = 1;
        for i = 1:3:len
          zz(:,i)   = x;
          zz(:,i+1) = y(k) * ones (xlen, 1);
          zz(:,i+2) = z(k,:)';
          k++;
        endfor
      else
        error (size_msg);
      endif
    else
      z_size = size (z);
      if (z_size == size (x) && z_size == size (y))
        nc = 3*z_size(1);
        zz = zeros (z_size(2), nc);
        zz(:,1:3:nc) = x';
        zz(:,2:3:nc) = y';
        zz(:,3:3:nc) = z';
      else
        error (size_msg);
      endif
    endif
    #__gnuplot_set__("nosurface");
    __gnuplot_set__("pm3d map");
    __gnuplot_set__("parametric");
    #__gnuplot_set__ view 0, 0, 1, 1;
    #__gnuplot_splot__ zz w l 1;
    __gnuplot_splot__ zz;
    __gnuplot_raw__("unset parametric\n");
  else
    error ("contour: x and y must be vectors and z must be a matrix");
  endif

endfunction
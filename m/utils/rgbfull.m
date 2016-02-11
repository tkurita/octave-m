function result = rgbfull(n_colors)
  # pkg load image
  # 2015-11-09 image-oct382 can't not be installed.
  # only colorgradient is copied.
  result = colorgradient([1,0,0,; 1,1,0; 0,1,0 ;0,1,1; 0,0,1; 1,0,1], n_colors);
endfunction

function result = rgbfull(n_colors)
  pkg load image
  result = colorgradient([1,0,0,; 1,1,0; 0,1,0 ;0,1,1; 0,0,1; 1,0,1], n_colors);
endfunction
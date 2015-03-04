function retval = moving_average(xy, n)
  x = xy(:,1);
  y = xy(:,2);
  maf1 = ones(n,1)./n;
  maf2 = normalize_filter(hamming(n).*maf1, 0);
  y2 = filter(maf2, 1, y);
  retval = [x(n:end), y2(n:end)];
endfunction
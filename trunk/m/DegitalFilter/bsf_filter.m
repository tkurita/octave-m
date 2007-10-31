function hn = bsf_filter(fs, fl, fh, L, N)
  n = 0:N;
  hn = sinc((n-L))+2*(fl/fs).*sinc((n-L)*2*(fl/fs)) -2*(fh/fs).*sinc((n-L)*2*(fh/fs));
  freqz(hn,1,10000,'whole',fs);
endfunction

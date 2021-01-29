## usage : hn = lpf_filter(fs, fc, L, N)
##
## N = 2*L + 1 is recommended
##
## fir1 を使った方が良さそうだ。ただし、fir1 の場合は自動的に窓関数がつく。
## （defaut で窓関数が付く）
## fir1(2*L, fc/(fs/2)) と同じ
##
##
## fs = 100;
## L = 7
## N = 2*L+1
## hn = lpf_filter(fs, 30, L, N);
## plot(fir1(2*L, 30/(fs/2)), ";fir1;", hamming(N).*hn', ";hamming(N)*hn;", hn', ";;")

function hn = lpf_filter(fs, fc, L, N)
  n = 0:(N-1);
  #wc = 2*pi*fc/fs;
  hn = 2*fc/fs.*sinc((n-L).*2*fc/fs);
  freqz(hn, 1, 1000, 'whole', fs);
endfunction

## -- retval = pade_tf(s, T, N)
##
##  return pade approximation of dead time transfer function
##
##  むだ時間伝達関数 e^(-s*T) の多項式近似であるパデ近似を求める。
##              1-s*T/2 + (s*T)^2/12 ...
##  e^(-s*T) ≈ --------------------------
##              1+s*T/2+ (s*T)^2/12 ...
##
##  * Inputs *
##    s : should be tf("s") or i*w 
##    T : time
##    N : order
##    
##  * Exmaple *
##    s = tf("s");
##    T = 0.1;
##    bode(pade_tf(s, T, 1))
##
##  See also: 

function retval = pade_tf(s, T, N)
  if ! nargin
    print_usage();
    return;
  endif
  [num, den] = padecoef(T, N);
  num_sum = 0; den_sum = 0;
  for n = 1:length(num)
    num_sum = num_sum+ num(n)*s^(N-n+1);
    den_sum = den_sum+ den(n)*s^(N-n+1);
  endfor
  
  retval = num_sum/den_sum;
endfunction

%!demo
%! pkg load control
%! s = tf("s");
%! T = 0.1;
%! bode(pade_tf(s, T, 1))

%!test
%! bode

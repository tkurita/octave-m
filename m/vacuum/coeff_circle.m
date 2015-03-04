## 円筒のコンダクタンスの補正係数 k
## C = k*116*(pi*(d/2)^2)
## 真空ハンドブック P39
## d : 直径
## l : 長さ

function retval = coeff_circle(d, l)
  ktable = [ ...
    0, 1;
    0.05, 0.952;
    0.1, 0.909;
    0.2, 0.834;
    0.4, 0.718;
    0.6, 0.632;
    0.8, 0.566;
    1.0, 0.514;
    2, 0.359;
    4, 0.232;
    6, 0.172;
    8, 0.137;
    10, 0.114;
    20, 0.061;
    40, 0.032;
    60, 0.02;
    100, (4*d)/(3*l)];
    
  lbyd = l/d;
  if lbyd > 100
    retval = (4*d)/(3*l);
  else
    retval = interp1(ktable(:,1), ktable(:,2), lbyd, "linear", "extrap");
  endif
  
endfunction
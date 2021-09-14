## -- retval = mode_match_PI("h", hn, "model", model)
##     部分モデルマッチング法で PI 制御器の最適値を計算する
##     制御対象の伝達関数は２次まで考慮される。
##
##  * Inputs *
##    b, a : 制御対象の伝達関数。The length of b and a must be 3.
##             b(1)s^n + b(2)*s^(n-1) + ... + b(n)
##             ------------------------------------
##             a(1)s^n + a(2)*s^(n-1) + ... + a(n)
##
##           高い次数が先
##
##    model : 参照モデル optional
##        0: 10% オーバーシュート
##        1: オーバーシュートなしで制定
##
##  * Outputs *
##    K_p + K_I/s
##    
##  * Exmaple *
##
##  See also: 

function varargout = model_match_PI(b, a, varargin)
  if ! nargin
    print_usage();
    return;
  endif
  opts = get_properties(varargin ...
        , {"model", 0});
  if 1 == length(opts.model)
    switch opts.model
      case 0
        A = [1,1,1/2, 3/20, 3/100, 3/10000];
      case 1
        A = [1,1, 3/8, 1/16, 1/256];
    endswitch
  else
    A = opts.model
  endif
  
  # 低い次数を先にする。
  b = flip(b);
  a = flip(a);

  # 長さが 3以下なら 0を追加する。
  b = _add_taling_zeros(b);
  a = _add_taling_zeros(a);

  h(1) = a(1)/b(1);
  h(2) = (a(2) - b(2)*h(1))/b(1);
  h(3) = (a(3) - b(2)*h(2)-b(3)*h(1))/b(1);
  # h
  #A = [1, 1, 1/2, 3/20];
  
  # 時間スケール sigma をもとめる。
  # 正かつ小さいものを選ぶ
  z_num1 = A(3)*h(2);
  z_num2 = sqrt(A(3)^2*h(2)^2 - 4*(A(3)^2 - A(4))*h(1)*h(3));
  if z_num1 > z_num2
    z_num2 = -1*z_num2;
  endif
  z = (z_num1 + z_num2)/(2*(A(3)^2 - A(4))*h(1));
  
  c(1) = h(1)/z;
  c(2) = h(2)/z - A(3)*h(1);
  # c
  K_P = c(2);
  K_I = c(1);

  printf("h = %s", disp(h))
  printf("sigma = %f, c = %s", z, disp(c))
  printf("K_P = %f, K_I = %f \n", K_P, K_I);
  varargout = {K_P, K_I};
endfunction

function x = _add_taling_zeros(x)
  x = x(:); # column wise
  if length(x) < 3
    x = [x; zeros(3-length(x), 1)];
  endif
end

%!test
%! func_name(x)

## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} bit_with_control_v(@var{arg})
## 関数発生器の出力電圧を設定ビット値に変換する
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
## 
## @seealso{}
## @end deftypefn

##== History
## 2014-01-30
## * renamed from contolVToBits.m

function bit = bit_with_control_v(control_v)
  control_v_amp = 20; #[V] 関数発生器最大出力 ±10V
  bit_max = 2^16-1; # 関数発生器設定値の最大値 16 bit
  # v_per_bit = control_v_amp/bit_max
  bit = round(control_v.*(bit_max/control_v_amp));
endfunction
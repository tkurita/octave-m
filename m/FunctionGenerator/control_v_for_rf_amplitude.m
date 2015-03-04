## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} control_v_for_rf_amplitude(@var{arg})
## 加速高周波電圧から制御電圧を求める
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

##== Log
## 2014-01-30
## * renamed from accVolToControlV

function control_v = control_v_for_rf_amplitude(rf_amp)
  control_v_max = 5; #[V] 加速高周波電圧設定信号の最大値
  rf_amp_max = 2000; #[V] 加速高周波電圧最大値

  control_v = rf_amp.*(control_v_max/rf_amp_max);
endfunction
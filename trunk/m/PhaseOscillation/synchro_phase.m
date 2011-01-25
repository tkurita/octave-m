## -*- texinfo -*-
## @deftypefn {Function File} {@var{ps}, @var{sin_ps} =} synchro_phase(@var{brho}, @var{tline}, @var{vline}, @var{C})
## Calculate of phase of synchronus particle.
## 
## @strong{Inputs}
## @table @var
## @item brho
## BM pattern in [T*m]
## @item tline
## list of time in [msec]
## @item vline
## RF voltage pattern [V]
## @item C
## circumference [m]
## @end table
##
## @strong{Outputs}
## @table @var
## @item ps
## phase angle in [rad]. always in 0 to pi/2 ignoring below and above transition.
## @item sin_ps
## sin(ps)
## @end table
##
## @end deftypefn


## usage: [ps,sin_ps] = synchro_phase(brho,tline,vline,C)
## synchronus particle の加速位相を計算
## transition 前後、RFの位相と時間軸の関係等を無視して、0 - pi/2 の範囲で計算する。
## bGrad : 磁場の変化率
## vline : 電圧パターン
## C : 周長 [m] WERC は 33.201mm

##== History
## 2011-01-25
## * accept Brho instead of BL
## * help with texinfo
## 2010-12-21
## * renamed from synchronusRFPhase
## * fixed for Octave 3.2
##
## 2009-10-30
## * It looks that gradient(tline/1000) is needed. gradient was changed ?

function [ps,sin_ps] = synchro_phase(brho, tline, vline, C)
  # brho = brho
  # tline = tline
  # vline = vline
  # C = 33.201
  # bGrad=gradient(brho, gradient(tline/1000)); #time difference of BM magnetic field
  bGrad=gradient(brho, (tline/1000));
  sin_ps = (C*bGrad/(pi/4))./vline;
  sin_ps(isnan(sin_ps)) = 0;
  ps =asin(sin_ps);
endfunction

## -*- texinfo -*-
## @deftypefn {Function File} {@var{ctrlv} =} HzToPhaseControlV(@var{hz}, @var{A2_PM2})
## Ovtain control voltages from the frequency characteristics of the harmonics porcessing unit giving phase 0.
##
## @strong{Inputs}
## @table @var
## @item Hz
## frequency
## @item A2_PM2
## A table of the frequency characteristics.
## @end table
##
## @strong{Outputs}
## @table @var
## @item ctrlv
## control voltage
## @end table
##
## @end deftypefn

## 周波数 [Hz] で移相器が 0 を与える設定電圧 [V] を求める。

function ctrlv = HzToPhaseControlV(hzList, A2_PM2, varargin)
  opts = get_properties(varargin, ...
                        {"method", "polyfit";
                          "fitorder", 8});
  fHz = A2_PM2(:,2);
  PM2 = A2_PM2(:,4);
  
  switch opts.method
      case "polyfit"
        [p, s, mu] = polyfit(fHz, PM2, opts.fitorder);
        ctrlv = polyval(p,(hzList-mu(1))./mu(2));
      otherwise # interp1 
        ctrlv = interp1(fHz, PM2, hzList);
  endswitch
  
  if (nargout < 1)
    y1 = polyval(p, (fHz-mu(1))./mu(2));
    p2 = [-13.28e-39;0.1445e-30;-0.4675e-24;-42.28e-21;3.04e-12;-6.168e-6;4.7445];
    y2 = polyval(p2,fHz);
    plot(fHz,PM2,"*",fHz,y1,"",fHz,y2,"")
  endif

endfunction
## -*- texinfo -*-
## @deftypefn {Function File} {@var{ctrlv} =} HzToAmpControlV(@var{Hz}, @var{A2_PM2})
## Obtain control voltage from frequency characteristics of harmonics processing unit.
## 
## @strong{Inputs}
## @table @var
## @item Hz
## list of frequency in Hz.
## @item A2_PM2
## a table of frequency characteristics
## @end table
##
## @strong{Outputs}
## @table @var
## @item ctrlv
## control voltage
## @end table
##
## @end deftypefn

# ２倍高調波信号処理装置の電圧設定の周波数特性

function ctrlv = HzToAmpControlV(hzList, A2_PM2, varargin)
  opts = get_properties(varargin, ...
                        {"method", "polyfit";
                          "fitorder", 8});
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  switch opts.method
      case "polyfit"
        [p, s, mu] = polyfit(fHz, A2, opts.fitorder);
        ctrlv = polyval(p,(hzList-mu(1))./mu(2));
      otherwise # interp1 
        ctrlv = interp1(fHz, A2, hzList);
  endswitch
  
  #plot(fHz,A2,"",fHz,y,"")
endfunction
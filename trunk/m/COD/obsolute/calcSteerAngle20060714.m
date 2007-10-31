## usage : kickAngle = calcSteerAngle(targetElement,iorB,brho)
##
##= parameters
## * targetElement : the element to calculate kick angle
## * iorB : current of magnet or magnetic filed. depend on targetElement
## * brho

function kickAngle = calcSteerAngle(targetElement, iorB, brho)
  theName = targetElement.name;
  ##= 縦方向の固定ステアラ
  if (findstr(theName,"STV") == 1) 
    bByIfactor = 3.66e-3/12;
    ## measurementFactor = 1/1.3; #COD測定から割り出した実際の影響度
    ## 同じ phisical length 0.3 m
    ## すると effective length は 0.23 m になる。
    ## 
    ## kickAngle = measurementFactor*bByIfactor*iorB*targetElement.len/brho;
    
    effLength = 0.23; #[m] #BL/I = 7.0150e-05
    kickAngle = bByIfactor*iorB*effLength/brho;
    
    ##= 横方向ステアラ
  elseif (findstr(theName, "STH") == 1) 
    ## 検査成績書から得た値
    ## kickAngle = steererAtoB(iorB)*targetElement.len/brho;
    ## iorB : ステアラーに流す電流量 [A]
    ## stB : 発生磁場 [T]
    ## phisLength = 50; #[mm]
    ## effLength = 218.41; #[mm]
    ## lengthfactor = effLength/phisLength;
    ##  stB = - lengthfactor * 0.004 .* ampere + 0.0012;
    ##  stB = - lengthfactor * 0.004 .* ampere;
    ##	stB = - lengthfactor * 0.00402363 .* ampere + 0.00081426;
    ## stB = - lengthfactor * 0.00402363 .* iorB ;
    ## kickAngle = stB * targetElement.len/brho;
    
    ## bl = iorB; #steerer の 1A あたりの BL 値を計算するときに使う
    ##日立の磁石特性データシートより
    bl = -8.5870e-4.* iorB; # [T m] #effective length 219mmくらい
    
    kickAngle = bl/brho;
    ##= QDに巻かれた backleg coil 
  elseif (findstr(theName,"QD") == 1)
    # 	if (strcmp(theName,"QD2") == 1)
    # 	  measurementFactor = 1/0.8;
    # 	elseif (strcmp(theName, "QD3") == 1)
    # 	  measurementFactor = 1/0.6;
    # 	else
    # 	  measurementFactor = 1;
    # 	endif
    ## phisical length は 0.15 m
    ## 測定による effective length は
    ## 0.15/0.8 = 0.18  
    ## 0.15/0.6 = 0.0.25
    ## ちなみに間を取って、0.15/0.7 = 0.21 [m] となる。この辺がただしそう
    #	kickAngle = measurementFactor * (6.4/10000)*iorB*targetElement.len/brho;
    
    effLength = 0.21; #[m]; たぶん松田さんに教わった値
    kickAngle = (6.4/10000).*iorB*effLength/brho;
    
    ##= 出射セプタム電磁石からの漏れ磁場
  elseif(findstr(theName,"SM") == 1)
    kickAngle = iorB.*targetElement.len/brho;
    
    ##= 出射バンプ
  elseif(findstr(theName,"BMPe1") == 1)
    #kickAngle = (1.46528e-1/340)*iorB*targetElement.len/brho;
    #expFactor = 124.234/122.8;
    expFactor = 1.40321000e-02/1.328e-02; #120A 付近
    kickAngle = expFactor*1.1069E-04.*iorB/brho;
  elseif(findstr(theName,"BMPe2") == 1)
    #expFactor = 109.828/120.9;
    expFactor = 0.013504/1.349e-02;
    kickAngle = expFactor*1.1241E-04.*iorB/brho;
    ##= 入射バンプ
  elseif(findstr(theName,"BMPi1") == 1)
    kickAngle = 6.8915E-05.*iorB/brho;
  elseif(findstr(theName,"BMPi2") == 1)
    kickAngle = 6.6656E-05.*iorB/brho;
  else
    ##= それ以外 -- iorB をBL [T*m] とする。
    # iorB > 0 の時、内側にキックするので、符号を反転させる。
    kickAngle = -1*iorB/brho;
  endif
endfunction
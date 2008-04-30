## usage: alpha = momentumCompactionFactor(allElements)
##
## momentum compaction factor を計算する。
## 
##= Parameter
##* allElements: すべての要素の matrix の配列。
##              calcLattice によって分散（field eater）が計算されている必要がある。

##== History
## 2008-04-30
## * momentumComactionFactor is obsolete. Use momentum_compaction_factor
## * Use is_BM intead of isBendingMagnet

function alpha = momentumCompactionFactor(allElements)
  warning("momentumComactionFactor is obsolete. Use momentum_compaction_factor.";
  ##calc mometum compaction factor
  alpha = 0;
  for n = 1:length(allElements)
    theElement = allElements{n};
    
    if (is_BM(theElement))
      theEater = (allElements{n-1}.eater(1)+theElement.eater(1))/2;
      alpha += theEater*theElement.bmangle;
    endif
  end
  
  #C = 33.201; #peripheral length [m]
  C = contourLength(allElements);
  alpha /= C;
endfunction


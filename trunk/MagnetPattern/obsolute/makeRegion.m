## usage : regionStruct = makeRegion(tlist,blist,fname)
##
## obsolute, use span_struct

function regionStruct = makeRegion(tlist,blist,fname)
#   tlist
#   blist
#   fname
  regionStruct.tPoints = tlist;
  regionStruct.bPoints = blist;
  regionStruct.funcType = fname;
  regionStruct.grad = gradient(blist)./gradient(tlist);
endfunction
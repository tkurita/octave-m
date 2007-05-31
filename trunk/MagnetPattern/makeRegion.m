## usage : regionStruct = makeRegion(tlist,blist,fname)
##

function regionStruct = makeRegion(tlist,blist,fname)
#   tlist
#   blist
#   fname
  regionStruct.tPoints = tlist;
  regionStruct.bPoints = blist;
  regionStruct.funcType = fname;
  regionStruct.grad = gradient(blist)/gradient(tlist);
endfunction
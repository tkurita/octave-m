## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} is_BM(@var{elememt_rec})
## 
## Return 1(true) if @var{element_rec} is a bending magnet.
## 
## Following case mean thart @var{element_rec} is a bending magnet.
## @itemize
## @item @var{elememnt_rec}.kind is "BM"
## @item @var{element_rec}.name is "BM"+number.
## @end itemize
## 
## @seealso{BM}
##
## @end deftypefn

##== History
## 2007-11-01
## * use "kind" field
## * deriverd from isBnedingManget

function result = is_BM(a_element)
  if (isfield(a_element, "kind"))
    result = strcmp(a_element.kind, "BM");
    return;
  endif
    
  findAns = findstr(a_element.name,"BM",0);
  if (length(findAns) && findAns(1)==1)
    isNumList = isdigit(a_element.name);
    if ((length(isNumList) > 2) && (isNumList(3)==1))
      result = true;
    else
      result = false;
    endif
  else
    result = false;
  endif
endfunction
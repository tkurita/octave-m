function result = matWithNames(dataTable, targetNames)
  for n = 1:length(targetNames)
    k = cellidx(dataTable.names, targetNames{n});
    if (k == 0)
      error("Can't find data name : %s", targetNames{k});
    endif
    
    result(:,n) = dataTable.data(:,k);
  endfor
  
endfunction

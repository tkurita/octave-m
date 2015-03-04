function ouputLatticeTable(lattice, value_keys, output)
#  lattice = latRec2005.lattice;
#  value_keys = {"entrancePosition", {"entranceBeta", "h"}};
  n_elements = length(lattice);
  n_keys = length(value_keys);
  output_cell = cell(n_elements+1, n_keys);
  
  ## setup title row
  output_cell{1,1} = "name";
  for m = 1:n_keys
    value_name = value_keys{m};
    if (iscell(value_name))
      value_name = joincell2string(value_name, ".");
    endif
    output_cell{1,m+1} = value_name;
  endfor
  
  for n = 1:n_elements
    output_cell{n+1,1} = lattice{n}.name;
    for m = 1:n_keys
      if (iscell(value_keys{m}))
        output_cell{n+1, m+1} = getfield(lattice{n}, value_keys{m}{:});
      else
        output_cell{n+1, m+1} = lattice{n}.(value_keys{m}); 
      endif
      
    endfor
    
  endfor
  
  cell2csv(output, output_cell);
endfunction

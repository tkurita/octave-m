## Usage : n0 = find_n0(tune, m)
##  find n0 where n0/m is closest to tune

function n0 = find_n0(tune, m)
  # tune = 1.6822;
  m_tune = m*tune;
  n = 1;
  pre_diff_n = abs(m_tune - n);
  while (true)
    n++;
    diff_n = abs(m_tune - n);
    if (diff_n > pre_diff_n)
      n0 = n - 1;
      break;
    else
      pre_diff_n = diff_n;
    endif
    
  endwhile
endfunction
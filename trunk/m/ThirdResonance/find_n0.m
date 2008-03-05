## Usage : n0 = find_n0(tune, m)
##  find n0 where n0/m is closest to tune

##== History
## 2008-02-20
## * The argument tune can be a matrix

function n0 = find_n0(tune, m)
  # tune = 1.6822;
  m_tune = m.*tune;
  an_ones = ones(rows(tune), columns(tune)) ;
  n = an_ones;
  pre_diff_n = abs(m_tune - n);
  com_n = an_ones;
  while (any(com_n))
    n = n + com_n;
    diff_n = abs(m_tune - n);
    com_n = pre_diff_n > diff_n;
    pre_diff_n = diff_n;
  endwhile
  n0 = n - an_ones;
endfunction


# find_n0([1.67, 1.67, 1.1], 3)
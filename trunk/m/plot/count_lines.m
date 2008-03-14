## current figre でプロットされている line の数を勘定する。
## 今のところ current figure だが、handle を与えて任意の figure の line を調べるように拡張したい。
## 

##== History
## 2008-03-09
## * first implementaion

function n_lines = count_lines()
  n_lines = length(get(get(gca, "children")));
end
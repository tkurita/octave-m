## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @table @code
## @item @var{history_cells}
## distill_history の output を与える
##
## @item @var{target_field}
## filter の対象とする @var{history_cells} のフィールド
##
## @item @var{acceptance}
## アクセプタンス
## 
## @end table
## @end deftypefn

function result = distill_particles(history_cells, min_turn, filter_target, acceptance)
  
  xthreshold = acceptance.xmin;
  n_index

endfunction
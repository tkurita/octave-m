## -*- texinfo -*-
## @deftypefn {Function File} {@var{bl_pattern} =} accumulate_bclock(@var{bclock}, @var{db}, @var{bl_fb}, [@var{periods}])
##
## Generate BL pattern by accumulating B-Clock.
##
## @strong{Inputs}
## @table @var
## @item bclock
## isf_data
## @item db
## Magnetic field differnece per on B Clock in [T*m]
## @item bl_fb
## BL at the flat base.
## @item periods
## Timmings to switch B-Clock ON/OFF. Optional.
## @end table
##
## @strong{Outputs}
## @table @var
## @item bl_pattern
## BL pattern.
## @end table
##
## @seealso{merge_bclock, interp_bclock}
## @end deftypefn

##== History
## 2013-08-22
## * initial implementaion

function retval = accumulate_bclock(bclock_data, db, bl_fb, 
                                              varargin)
  th = -1;
  pw = 5e-6; # B-Clock パルス幅 [sec]
  xydata = xy(bclock_data);
  dy = diff(xydata(:,2));
  dt = bclock_data.ts;
  lind = find(dy < th);

  # 5usec 以内の重複したデータは若いindex を残して削除する。
  a = pw/dt;
  n_lind = -1*flipud(lind);
  n_lind(find(diff(n_lind) <= a)) = [];
  nn_lind = -1*flipud(n_lind);
  lind = nn_lind;
  t_list = (lind-1).*dt;
  
  # B-Clock を無視する領域を考慮
  if (length(varargin) > 0)
    t_periods = varargin{1};
    t_beg = 0;
    is_off = 1;
    for t_end = t_periods
      if is_off
        t_list(t_list > t_beg & t_list <= t_end) = [];
      endif
      t_beg = t_end;
      is_off = ! is_off;
    endfor
  endif
  
  # 磁場データを構築
  db_list = (1:length(t_list)).*db;
  bl_list = db_list.+bl_fb;
  
  # 最初と最後のデータを補完
  if (xydata(1,1) < t_list(1))
    t_list = [xydata(1,1); t_list];
    bl_list = [bl_list(1)-db, bl_list];
  endif
  
  if (xydata(end, 1) > t_list(end))
    t_list(end+1) = xydata(end, 1);
    bl_list(end+1) = bl_list(end);
  endif
  
  retval = [t_list(:), bl_list(:)];
endfunction

%!test
%! accumulate_bclock(x)

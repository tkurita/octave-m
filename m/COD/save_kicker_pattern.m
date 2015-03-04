## -*- texinfo -*-
## @deftypefn {Function File} {} save_kicker_pattern(@var{file}, @var{t}, @var{cod_rec_FB}, @var{cod_rec_FT})
## Output pattern file of kickers from COD Record objects as CSV format.
##
## Kicker values are inverted in COD Record Objects.
## 
## @table @code
## @item @var{t}
## Timmings for trapezoidal pattern. The length must be 14;
## @item @var{cod_rec_FB}
## COD Record Object for Flat Base
## @item @var{cod_rec_FT}
## COD Record Object for Flat Top
## @end table
## 
## @end deftypefn

##== History
## 2008-12-03
## * first implementation

function retval = save_kicker_pattern(file, t, cod_rec_FB, cod_rec_FT)
  # file = "testout"
  kickers = cod_rec_FB.steererNames;
  val_fb = -1*cod_rec_FB.steererValues;
  val_ft = -1*cod_rec_FT.steererValues;
  [fid, msg] = fopen(file, "w");
  for n = 1:length(val_fb)
    fprintf(fid, "#\n%s,\n", convname(kickers{n}));
    bpat = trapz_pattern(t, val_fb(n), val_ft(n));
    csv_with_bpattern(bpat, fid);
  endfor
  fclose(fid);
endfunction

function retval = convname(name)
  name_table = {"St1I", "STH1";
                "St2I", "STH2";
                "St3I", "STH3";
                "St4I", "STH4";
                "St5I", "STH5";
                "St6I", "STH6"};
  for n = 1:rows(name_table)
    name_row = name_table(n,:);
    if (contain_str(name_row, name))
      retval = name_row{1};
    endif
  endfor
endfunction
%!test
%! save_kicker_pattern(x)

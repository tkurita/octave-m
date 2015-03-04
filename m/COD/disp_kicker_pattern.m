## -*- texinfo -*-
## @deftypefn {Function File} {} disp_kicker_pattern(@var{t}, @var{cod_rec_FB}, @var{cod_rec_FT}, [@var{fid}])
## Output pattern file of kickers from COD Record objects with table form.
## 
## Steerer values are inverted.
## 
## @table @code
## @item @var{t}
## Timmings for trapezoidal pattern. The length must be 14;
## @item @var{cod_rec_FB}
## COD Record Object for Flat Base
## @item @var{cod_rec_FT}
## COD Record Object for Flat Top
## @item @var{fid}
## Screaming number. The default is 1 i.e. stdout.
## @end table
## 
## @end deftypefn

##== History
## 2008-12-03
## * first implementation

function retval = disp_kicker_pattern(t, cod_rec_FB, cod_rec_FT, varargin)
  if (length(varargin))
    fid = varargin{1};
  else
    fid = stdout;
  endif
  # fid = popen("pbcopy", "w")
  # file = "testout"
  kickers = cod_rec_FB.steererNames;
  val_fb = -1*cod_rec_FB.steererValues;
  val_ft = -1*cod_rec_FT.steererValues;
  bpat_cells = {};
  for n = 1:length(val_fb)
    bpat = trapz_pattern(t, val_fb(n), val_ft(n));
    bpat_cells{end+1} = bpat;
  endfor
  
  bpat_mat = mat_with_bpattern(bpat_cells{1});
  for n = 2:length(bpat_cells)
    a_mat = mat_with_bpattern(bpat_cells{n});
    bpat_mat(:,n+1) = a_mat(:,2);
  endfor
  
  fprintf(fid, "time\t%s\n", joincell2string(kickers, "\t"));
  template = ftemplate_for_mat(bpat_mat(1,2:end), "precision", "%.2f", "delim", "\t");
  template = ["%.1f\t", template];
  for n = 1:rows(bpat_mat)
    fprintf(fid, template, bpat_mat(n, :));
  endfor
  
endfunction


%!test
%! disp_kicker_pattern(t, cod_rec_FB, cod_rec_FT)

## -*- texinfo -*-
## @deftypefn {Function File} {@var{sx_rec} =} setup_sx(@var{sx_rec}, @var{brho})
## 
## setup sextupole magnet element for tracking.
##
## The input @var{sx_rec} must have following fields.
##
## @table @code
## @item name
## @item current
## @end table
##
## The following field is appended into the output @var{sx_rec}.
##
## @table @code
## @item strength
## [1/(m*m)]
## @item llamda 
## strength/2
## @item efflen
## effective length [m]
## @item premat
## @item postmat
## @item apply
## function handle to kick particles.
## The default value is @@sx_thin_kick
## @end table
##
## @seealso{sx_thin_kick}
##
## @end deftypefn

##==History
## 2018-03-08
## * SX2 の I-H 曲線の間違いを修正
## * 日立からもらった OPSYNRN.XLS ナイのSX1,2,3 の I-HL の導出が
##   おかしいように思える。
## * 検査成績書より有効長を 244mm として、I-H にかけて I-HL を出す。

function sx_rec = setup_sx(sx_rec, brho, varargin)
  sx_rec.brho = brho;
  current = sx_rec.current;
  switch sx_rec.name
    case "SX1"
      # hl = 1.0423e-01 * current - 1.7764E-15; #[T/m2 m]
      h = 4.4109E-01 * current + 1.0264E+00; #[T/m2]
    case "SX2"
      # hl = 1.0333E-01 * current - 1.7754e-15;
      h =  4.4859E-01*current + 8.3525E-01;
    case "SX3"
      #hl = 1.0533E-01 * current + 1.7764E-15;
      h = 4.4038E-01 * current + 7.9585E-01;
    otherwise
      error("unknown sextupole element : %s", name);
  endswitch
  efflen = 0.244; #[m] effective length
  hl = h*efflen;
  #al = 0.2; #[m] actual length
  sx_rec.strength = hl/brho;
  sx_rec.llamda = sx_rec.strength/2;
  sx_rec.efflen = efflen; #[m] effective length
  if (length(varargin) > 1)
    sx_rec.apply = varargin{1};
  else
    sx_rec.apply = @through_sx;
  endif
  
  a_mat = sx_rec.mat_half;
  sx_rec.premat = [a_mat.h, zeros(3); zeros(3), a_mat.v];  
  sx_rec.postmat = sx_rec.premat;
  sx_rec.track_info = "special";
  sx_rec.kind = "SX";
endfunction

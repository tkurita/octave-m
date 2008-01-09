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
## The default value is @sx_thin_kick
## @end table
##
## @seealso{sx_thin_kick}
##
## @end deftypefn

function sx_rec = setup_sx(sx_rec, brho, varargin)
  sx_rec.brho = brho;
  current = sx_rec.current;
  switch sx_rec.name
    case "SX1"
      hl = 1.0423e-01 * current + 1.7764E-15; #[T/m2 m]
      h = 4.4109E-01 * current + 1.0264E+00; #[T/m2]
    case "SX2"
      hl = 1.0333E-01 * current;
      h = 8.3525E-01 * current + 4.4859E-01;
    case "SX3"
      hl = 1.0533E-01 * current - 7.1054E-15;
      h = 4.4038E-01 * current - 7.9585E-01;
    otherwise
      error("unknown sextupole element : %s", name);
  endswitch
  
  #al = 0.2; #[m] actual length
  sx_rec.strength = hl/brho;
  sx_rec.llamda = sx_rec.strength/2;
  sx_rec.efflen = hl/h; #[m] effective length
  if (length(varargin) > 1)
    sx_rec.apply = varargin{1};
  else
    sx_rec.apply = @through_sx;
  endif
  
  #a_mat = DTmat(al/2);
  a_mat = sx_rec.mat_half;
  sx_rec.premat = [a_mat.h, zeros(3); zeros(3), a_mat.v];  
  sx_rec.postmat = sx_rec.premat;
  sx_rec.track_info = "special";
endfunction

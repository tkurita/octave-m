## usage : sx = sextupoleSetting(brho, current, name [,option] )
##
## sx.
## 
##= Parameters
## * option -- "thin" Ç™ê›íËÇ≥ÇÍÇÈÇ∆ thin lens ãﬂéó

function sx = sextupoleSetting(brho, current, name, varargin)
  if (length(varargin))
    option = varargin{1};
  else
    option = "3rd";
  endif
  
  sx = struct("brho", brho, "current", current, "name", name);
  
  switch name
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
  
  al = 0.2; #[m] actual length
  llamda = (1/2) * hl/brho;
  l = hl/h; #[m] effective length
  l2lamda = llamda*l;
  l2lamda2 =l2lamda/2;
  l3lamda = llamda*l^2;
  l3lamda3 = l3lamda/3;
  switch option
    case "thin"
      sx.kick = @sextupoleKickThin;
      dl=al/2;
    case "1st"
      #x, x',     x2, y, y'     y2      xy 
      sx.mat =\
      [1, 0,       0, 0, 0,      0,     0;
      0, 1, -llamda, 0, 0, llamda,     0;
      0, 0,       0, 1, 0,      0,     0;
      0, 0,       0, 0, 1,      0, llamda];
      dl=al/2;
      sx.kick = @sextupoleKick1stThin;
    otherwise
      #  x, x',       x2,       xx', y,y',       y2,      yy',      xy,      xy', x'y
      sx.mat =\
      [1, l, -l2lamda2, -l3lamda3, 0, 0, l2lamda2, l3lamda3,       0,        0, 0;
      0, 1,   -llamda,  -l2lamda, 0, 0,   llamda,  l3lamda,       0,        0, 0;
      0, 0,         0,         0, 1, l,        0,        0, l2lamda, l3lamda3, l3lamda3;
      0, 0,         0,         0, 0, 1,        0,        0,     2*l,  l2lamda, l2lamda];
      dl = (al-l)/2;
      sx.kick = @sextupoleKick3rd;
  endswitch
  
  sx.premat =\
  [1, dl, 0, 0;
  0, 1,  0, 0;
  0, 0,  1, dl,
  0, 0,  0, 1]; 
  
  sx.postmat =\
  [1, dl, 0, 0;
  0, 1,  0, 0;
  0, 0,  1, dl,
  0, 0,  0, 1]; 
  
  sx.llamda = llamda;
  sx.len = l;
endfunction

## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} image_coefficients(@var{element})
##
## @end deftypefn

##== History
##

function retval = image_coefficients(elem)
  switch (elem.kind)
    case ("QD")
      retval = image_coefficents_circle();
    case ("QF")
      retval = image_coefficents_paralell();
    case ("BM")
      retval = image_coefficents_paralell();
    otherwise
      switch (elem.duct.shape)
        case ("rect")
          retval = image_coefficents_paralell();
        case ("circle")
          retval = image_coefficents_circle();
      endswitch
  endswitch
endfunction

function retval = image_coefficents_paralell()
  ep1.h = -pi^2/48;
  ep1.v = - ep1.h;
  ep2.h = -pi^2/24;
  ep2.v = - ep2.h;
  xi1.h = 0;
  xi1.v = pi^2/16;
  xi2.h = 0;
  xi2.v = pi^2/16;
  retval = tars(ep1, ep2, xi1, xi2);
endfunction

function retval = image_coefficents_circle()
  ep1.h = 0;
  ep1.v = - ep1.h;
  ep2.h = 0;
  ep2.v = - ep2.h;
  xi1.h = 1/2;
  xi1.v = 1/2;
  xi2.h = 0; #unknown
  xi2.v = 0; #unknown
  retval = tars(ep1, ep2, xi1, xi2);
endfunction

%!test
%! func_name(x)

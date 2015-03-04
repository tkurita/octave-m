## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} average_beta(@var{arg})
##
## @end deftypefn

##== History
## 2009-10-28
## * initial

function retval = average_beta(an_element)

  switch (an_element.kind)
    case ("QF")
      sqk = sqrt(abs(an_element.k));
      if (isfield(an_element, "efflen"))
        l = an_element.efflen;
        dl = (an_element.len - an_element.efflen)/2; # negative
        twpar0 = an_element.entranceTwpar;
        dltwmat = twp_matrix(DTmat(dl));
        twpar1.h = dltwmat*twpar0.h;
        twpar1.v = dltwmat*twpar0.v;
        #twpar1
      else
        l = an_element.len;
        twpar1 = an_element.entranceTwPar;
      endif
      
      retval.h = avg_beta_qf(sqk, l, twpar1.h);
      retval.v = avg_beta_qd(sqk, l, twpar1.v);
      #retval
      if (isfield(an_element, "efflen"))
        db.entrance.h = avg_beta_duct(dl, twpar0.h);
        db.entrance.v = avg_beta_duct(dl, twpar0.v);
        twpar2.h = twp_matrix(QFmat(an_element))*twpar1.h;
        twpar2.v = twp_matrix(QDmat(an_element))*twpar1.v;
        db.exit.h = avg_beta_duct(dl, twpar2.h);
        db.exit.v = avg_beta_duct(dl, twpar2.v);
        retval.h = (retval.h*l + db.entrance.h*dl + db.exit.h*dl)/an_element.len;
        retval.v = (retval.v*l + db.entrance.v*dl + db.exit.v*dl)/an_element.len;
      endif
      
    case("QD")
      sqk = sqrt(abs(an_element.k));
      if (isfield(an_element, "efflen"))
        l = an_element.efflen;
        dl = (an_element.len - an_element.efflen)/2; # negative
        twpar0 = an_element.entranceTwpar;
        dltwmat = twp_matrix(DTmat(dl));
        twpar1.h = dltwmat*twpar0.h;
        twpar1.v = dltwmat*twpar0.v;
      else
        l = an_element.len;
        twpar1 = an_element.entranceTwPar;
      endif
      retval.h = avg_beta_qd(sqk, l, twpar1.h);
      retval.v = avg_beta_qf(sqk, l, twpar1.v);
      if (isfield(an_element, "efflen"))
        db.entrance.h = avg_beta_duct(dl, twpar0.h);
        db.entrance.v = avg_beta_duct(dl, twpar0.v);
        twpar2.h = twp_matrix(QDmat(an_element))*twpar1.h;
        twpar2.v = twp_matrix(QFmat(an_element))*twpar1.v;
        db.exit.h = avg_beta_duct(dl, twpar2.h);
        db.exit.v = avg_beta_duct(dl, twpar2.v);
        retval.h = (retval.h*l + db.entrance.h*dl + db.exit.h*dl)/an_element.len;
        retval.v = (retval.v*l + db.entrance.v*dl + db.exit.v*dl)/an_element.len;
      endif
      
    case("BM")
      
      if (isfield(an_element, "efflen"))
        rho = an_element.efflen/an_element.bmangle;
        l = an_element.efflen;
        dl = (an_element.len - an_element.efflen)/2; # negative
        twpar0 = an_element.entranceTwpar;
        dlmat = DTmat(dl);
        dltwmat = twp_matrix(dlmat);
        twpar1.h = dltwmat*twpar0.h;
        twpar1.v = dltwmat*twpar0.v;
      else
        rho = an_element.radius;
        l = an_element.len;
        twpar1 = an_element.entranceTwPar;
      endif
      edgeangle = an_element.edgeangle;
      twpar1.h = twp_matrix(BME_H(rho, edgeangle))*twpar1.h;
      twpar1.v = twp_matrix(BME_V(rho, edgeangle))*twpar1.v;
      retval.h = avg_beta_qf(1/rho, l, twpar1.h);
      retval.v = avg_beta_duct(l, twpar1.v);
      if (isfield(an_element, "efflen"))
        db.entrance.h = avg_beta_duct(dl, twpar0.h);
        db.entrance.v = avg_beta_duct(dl, twpar0.v);
        twpar2.h = twp_matrix(BMHmat(rho, an_element.bmangle, 0))*twpar1.h;
        twpar2.v = twp_matrix(DTmat(l))*twpar1.v;
        twpar2.h = twp_matrix(BME_H(rho, edgeangle))*twpar2.h;
        twpar2.v = twp_matrix(BME_V(rho, edgeangle))*twpar2.v;
        db.exit.h = avg_beta_duct(dl, twpar2.h);
        db.exit.v = avg_beta_duct(dl, twpar2.v);
        retval.h = (retval.h*l + db.entrance.h*dl + db.exit.h*dl)/an_element.len;
        retval.v = (retval.v*l + db.entrance.v*dl + db.exit.v*dl)/an_element.len;
      endif

    otherwise
      retval.h = avg_beta_duct(an_element.len, an_element.entranceTwpar.h);
      retval.v = avg_beta_duct(an_element.len, an_element.entranceTwpar.v);
  endswitch

endfunction

function retval = avg_beta_duct(l, twpar)
  b1 = twpar(1);
  a1 = twpar(2);
  g1 = twpar(3);
  retval = b1 - l*a1+(1/3)*l^2*g1;
end

function retval = avg_beta_qd(k, l, twpar)
  b1 = twpar(1);
  a1 = twpar(2);
  g1 = twpar(3);  
  retval = (1/2)*(b1 - g1/k^2) + a1/(2*k^2*l)...
        + (1/(4*k*l))*(b1+g1/k^2)*sinh(2*k*l)...
        - a1/(2*l*k^2)*cosh(2*k*l);
endfunction

function retval = avg_beta_qf(k, l, twpar)
  b1 = twpar(1);
  a1 = twpar(2);
  g1 = twpar(3);  
  retval = (1/2)*(b1 + g1/k^2) - a1/(2*k^2*l)...
        +(1/(4*k*l))*(b1-g1/k^2)*sin(2*k*l)...
        + a1/(2*l*k^2)*cos(2*k*l);
endfunction
%!test
%! lattice_definition("buildWERCMatrix");
%! lat_rec_FB.time = 35;
%! lat_rec_FB = lattice_with_time(lat_rec_FB);
%! average_beta(x)

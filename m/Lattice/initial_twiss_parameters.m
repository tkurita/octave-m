## -*- texinfo -*-
## @deftypefn {Function File} {@var{twp_rec} =} initial_twiss_parameters(@var{onerev_mat})
##
## calculate initial twiss paramerters from the one revolution matrix.
##
## @{twp_rec} has following fields.
##
## @table @code
## @item twp
## a matrix of twiss parameters. [beta; alpha; gamma]
##
## @item cosmu
## cos(mu) = (@var{onerev_mat}(1,1)+@var{onerev_mat}(2,2))/2;
## @end table
## 
## @end deftypefn

##== History
## 2008-06-18
## * renamed from twissParameter

function twp_rec = initial_twiss_parameters(onerev_mat)
  cosmu = (onerev_mat(1,1)+onerev_mat(2,2))/2;
  
  if onerev_mat(1,2) >= 0
    sinmu = sqrt(1-cosmu^2);
  else
    sinmu = -sqrt(1-cosmu^2);
  endif
  
  beta0 = onerev_mat(1,2)/sinmu;
  
  alpha0 = (onerev_mat(1,1)-onerev_mat(2,2))/(2*sinmu);
  
  gamma0 = (1+alpha0^2)/beta0;
  
  twp_rec.twp = [beta0;alpha0;gamma0];
  twp_rec.cosmu = cosmu;
endfunction
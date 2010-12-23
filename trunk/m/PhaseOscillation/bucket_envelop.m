## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} bucket_envelop(@var{phy_s})
##
## @end deftypefn

##== History
## 2010-12-23
## * renamed form bucketEnvelop in BucketSizeLib

function retval = bucket_envelop(phi_s)
  # phi_s = pi/4
  [phi_1,info] = solve_phi1(phi_s);
  phi_2 = pi - phi_s;
  if (phi_s < pi/2)
	## before transition
	phi_range = phi_1:0.01:(phi_2+pi/4);
  else
	## after transition
	phi_range = (phi_2-pi/4):0.01:phi_1;
	if (phi_range(length(phi_range)) != phi_1)
	  phi_range = [phi_range,phi_1];
	endif
  endif
  
  bucketEnvelopList =  (1/(8*sqrt(2))).*rfbucket_half_height(phi_range, phi_s, phi_1);
  retval = [phi_range(:), bucketEnvelopList(:)];
endfunction

%!test
%! func_name(x)

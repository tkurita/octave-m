## -*- texinfo -*-
## @deftypefn {Function File} {} noise_rf(@var{vmax}, @var{nu}, @var{width}, @var{df}, @var{n_rev}, [@var{h}])
##
## Generate pseudo noise pattern
##
## @table @code
## @item @var{vmax}
## maximamu voltage
##
## @item @var{nu}
## @var{nu} * frev is RF kickers's frequency
## 
## @item @var{width}
## The band width of RF is 2*@var{width}*frev.
## 
## @item @var{df}
## frequency spacing of the noise is @var{df}*frev
##
## @item @var{n_rev}
## The length of the output is @var{n_rev}
##
## @end table
## @end deftypefn

##== History
## 2008-03-19
## * first implementaion

function result = noise_rf(vmax, nu, width, df, n_rev)
  n_turn = 0:n_rev;
  nf = 0:df:width;
  dphi = rand(1,length(nf))*2*pi;
  v0 = zeros(1, n_rev+1);
  for t = n_turn
    v0(t+1) = sum(sin(2*pi*(nu + nf)*t+dphi) + sin(2*pi*(nu - nf)*t-dphi));
    #v0(t+1) = sum(sin(2*pi*((h+nu) + nf)*t+dphi) + sin(2*pi*((h+nu) - nf)*t-dphi));
#    v0(t+1) = sum(sin(2*pi*((h+nu) + nf)*t+dphi) + sin(2*pi*((h+nu) - nf)*t-dphi) ...
#                  + (sin(2*pi*((h+nu) + nf)*t+dphi+pi/2) + sin(2*pi*((h+nu) - nf)*t-(dphi+pi/2))));
  end
  result = vmax*v0/max(v0);
endfunction
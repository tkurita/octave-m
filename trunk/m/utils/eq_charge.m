## -*- texinfo -*-
## @deftypefn {Function File} {[@var{q}, @var{dq}] =} eq_charge(@var{z}, @var{particle}, @var{mev})
## 
## Return equilibrium charge state and distribution width
## 
## @table @code
## @item @var{z}
## Atomic number
## @item @var{particle}
## Mass number
## @item @var{mev}
## Kinetic Energy in MeV
## @end table
##
## @table @code
## @item @var{q}
## equilibrium charge state
## @item @var{dq}
## width of charge state distribution
## @end table
## 
## equilibrium charge state : R.O.Sayer Review. de. Phys. App. 12('77)1543
## distribution width : I.S.Dmitrie and Nkolaev JETP 20('65)409
## @end deftypefn

##== History
##

function [q, dq] = eq_charge(z, particle, mev)
  # mev = 5
  # z = 29
  # particle = 64
  b = beta_with_mev(mev, particle);
  q = z*(1-1.08*exp(-80.1*(z^-0.506)*(b^0.996)));
  dq = 0.32*z^0.45;
endfunction

%!test
%! eq_charge(x)

## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} pump_info(@var{ds})
##
## @var{ds} : shifted value of origin
## @end deftypefn

##== History
##

function retval = pump_info(ds)
  # ds = -0.875;
  C = 33.201;
  if !nargin
    ds = 0;
  endif
  # name, position [m], pumping speed [m^3/s]
  retval =  {"CP1", 32.496, effective_pumping_speed(1400e-3, conductance_circle(108.3e-3, 0.22e-3));
            "TMP1", 32.976, effective_pumping_speed(700e-3, conductance_circle(159e-3, 0.09e-3));
            "IP2", 1.58, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP3", 4.2751, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP4", 7.2252, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP5", 9.7952, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP6", 12.55, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "CP2", 15.915, effective_pumping_speed(1400e-3, conductance_circle(159e-3, 0.09e-3));
            "TMP2", 16.315, effective_pumping_speed(700e-3, conductance_circle(159e-3, 0.09e-3));
            "IP8", 18.25, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP9", 21.601, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP10", 25.011, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3));
            "IP11", 26.326, effective_pumping_speed(140e-3, conductance_circle(108.3e-3, 0.15e-3))};
   if ds
     x = cell2mat(retval(:,2)) - ds;
     x = -(x > C)*C + x;
     retval(:,2) = mat2cell(x, ones(1,rows(x)), 1);
   end
endfunction

%!test
%! func_name(x)

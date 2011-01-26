## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} calc_vaccum_distribution(@var{q_base}, @var{q_esi}, @var{q_esd})
##
## @table @code
## @item @var{q_base}
## outgas per unit area
## @item @var{q_esi}
## outgas of ESI chamber
## @item @var{q_esd}
## outgas of ESD chamber
## @end table
##
## @end deftypefn

##== History
##

function retval = calc_vaccum_distribution(q_base, q_esi, q_esd)
  lattice_definition("build_vaccum_duct");
  lat_rec =calc_lattice(1.7288, -1.758);
  elem_list = lat_rec.lattice;
  # q_base = 0.5e-6;
  # q_esi = 6.3841e-06;
  # q_esd = 1.1514e-05;
  # ESI チャンバー
  ESI_chamber.S = 1.1850; # [m^2]
  ESI_chamber.q =  q_esi; # [Pa m^3/s] viton o-ring
  ESI_chamber.name = "ESI"; 
  
  # ESD チャンバー
  ESI_chamber.S = 2.0475; # [m^2]
  ESD_chamber.q = q_esd; # [Pa m^3/s]
  ESD_chamber.name = "ESD";
  
  special_chambers = {ESI_chamber, ESD_chamber};
  
  vac_elems = [];
  for n = 1:length(elem_list)
    # n = 1;
    x = elem_list{n};
    if x.len == 0 
      continue;
    endif
    
    cells = find_with_keypath(special_chambers, {"name"}, x.name);
    if length(cells)
      velem = cells{1};
    else
      velem.S = internal_area(x); # area [m^2]
      velem.q = velem.S*q_base; # outgas (Pa m^3)/s
    endif
    
    velem.half_C = vac_conductance(x, "half"); # conductance [m^3/s]
    
    # setup pumping speed [m^3/s]
    velem.pumping_speed = pumping_speed_for(x);
    
    # setup positions
    velem.entrancePosition = x.entrancePosition;
    velem.exitPosition = x.exitPosition;
    velem.centerPosition = x.centerPosition;
    
    vac_elems{end+1} = velem;
  end
  
  n_elems = length(vac_elems);
  q_mat = zeros(n_elems,1);
  cs_mat = zeros(n_elems, n_elems);
  
  for n = 2:(n_elems-1)
    pre_C = 1/(1/vac_elems{n-1}.half_C + 1/vac_elems{n}.half_C);
    post_C = 1/(1/vac_elems{n}.half_C + 1/vac_elems{n+1}.half_C);
    cs_mat(n,n-1) = - pre_C;
    cs_mat(n,n) = pre_C+post_C+vac_elems{n}.pumping_speed;
    cs_mat(n,n+1) = -post_C;
    q_mat(n) = vac_elems{n}.q;
  endfor
  
  n = 1;
  pre_C = 1/(1/vac_elems{end}.half_C + 1/vac_elems{n}.half_C);
  post_C = 1/(1/vac_elems{n}.half_C + 1/vac_elems{n+1}.half_C);
  cs_mat(n,end) = - pre_C;
  cs_mat(n,n) = pre_C+post_C+vac_elems{n}.pumping_speed;
  cs_mat(n,n+1) = -post_C;
  q_mat(n) = vac_elems{n}.q;
  
  n = n_elems;
  pre_C = 1/(1/vac_elems{n-1}.half_C + 1/vac_elems{n}.half_C);
  post_C = 1/(1/vac_elems{n}.half_C + 1/vac_elems{1}.half_C);
  cs_mat(n,n-1) = - pre_C;
  cs_mat(n,n) = pre_C+post_C+vac_elems{n}.pumping_speed;
  cs_mat(n,1) = -post_C;
  q_mat(n) = vac_elems{n}.q;
  
  p_mat = cs_mat\q_mat;
  x_pos = value_for_keypath(vac_elems, "centerPosition");
  retval = [x_pos(:), p_mat(:)];
  # xyplot(retval);grid on; set(gca, "yscale", "log"); xlabel("[m]"); ylabel("[Pa]"); xlim([0,33.2]);
endfunction

%!test
%! func_name(x)

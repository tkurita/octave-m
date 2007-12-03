function out_particles = particles_in_parallelogram(a_para, n_particle)
  out_particles = [];
  for (xory = ["x","y"])
    delta_x = a_para.([xory, "max"]) - a_para.([xory, "min"]);
    x = rand(1,n_particle)*delta_x + a_para.([xory, "min"]);
    k = -(a_para.([xory, "dash_max"]).h - a_para.([xory, "dash_min"]).h)/delta_x;
    x0d_h = a_para.([xory,"dash_max"]).h + k*a_para.([xory,"max"]);
    x0d_l = a_para.([xory,"dash_max"]).l + k*a_para.([xory,"max"]);
    xdash = rand(1,n_particle)*(x0d_h - x0d_l) + x0d_l;
    particles = [1, 0; -k,1]*[x; xdash];
    #particles = [x;xdash];
    out_particles(end+1:end+2,:) = particles;
    out_particles(end+1, :) = zeros(1,n_particle);
  end
  
end

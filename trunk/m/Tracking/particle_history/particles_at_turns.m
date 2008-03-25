## Usage : out_particles = particles_at_turns(particle_hist, elem_name, turn_range, [horv])
##              or
##         out_particles = particles_at_turns(particle_hist, "initial", [horv])
##
## units of particle_hist is [rad] and [m]
## units of output is [mrad] and [mm]
## horv is ommited, return a matrix of form of [x, x', delp, y, y',delp]

##== History
## 2008-03-21
## * make faster by not using cell2mat.
## * 
## 2007-12-04
## * when horv is not given, a matrix of form of [x, x', delp, y, y',delp]
##
## 2007-10-03
## * initial implementation

#function out_particles = particles_at_turns(particle_hist, elem_name, turn_range, varargin)
function out_particles = particles_at_turns(varargin)
  # turn_range = [100,250]
  # elem_name = "ESD"
  # varargin = {"h"}
  particle_hist = varargin{1};
  elem_name = varargin{2};
  horv = "hv";
  if (ischar(varargin{end}))
    switch varargin{end}
      case "h"
        horv = "h";
      case "v"
        horv = "v";
    endswitch
  endif
  
  if (ismatrix(varargin{3}))
    turn_range = varargin{3};
  elseif (!strcmp(elem_name, "initial"))
    error("turn range is not specified.");
  endif
  
  if (strcmp(elem_name, "initial"))
    particles = particle_hist.(elem_name);
  else
    particles_in_turns = particle_hist.(elem_name)(turn_range(1):turn_range(end));
    # particles = cell2mat(particles);
    num_particle = columns(particles_in_turns{1});
    particles = zeros(6,length(particles_in_turns)*num_particle);
    for n = 1:length(particles_in_turns)
      m = 1 + num_particle*(n - 1);
      particles(:, m:m+(num_particle-1)) = particles_in_turns{n};
    end
  endif

  switch horv
    case "h"
      out_particles = particles(1:2,:);
    case "v"
      out_particles = particles(4:5,:);
    otherwise
      out_particles = particles;
  endswitch
  
  out_particles = clean_particles(out_particles)'.*1e3;
endfunction

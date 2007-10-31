#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.10 Tracking/extraction_tracking.m
## Usage : out_particles = particles_at_turns(particle_hist, elem_name, turn_range, [horv])
##              or
##         out_particles = particles_at_turns(particle_hist, "initial", [horv])
##
## units of particle_hist is [rad] and [m]
## units of output is [mrad] and [mm]
##

##== History
## 2007-10-03
## * initial implementation

#function out_particles = particles_at_turns(particle_hist, elem_name, turn_range, varargin)
function out_particles = particles_at_turns(varargin)
  # turn_range = [100,250]
  # elem_name = "ESD"
  # varargin = {"h"}
  particle_hist = varargin{1};
  elem_name = varargin{2};
  horv = "h";
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
    particles = particle_hist.(elem_name)(turn_range(1):turn_range(end));
    particles = cell2mat(particles);    
  endif

  switch horv
    case "h"
      out_particles = particles(1:2,:);
    case "v"
      out_particles = particles(4:5,:);
  endswitch
  
  out_particles = cleanParticles(out_particles)'.*1e3;
endfunction

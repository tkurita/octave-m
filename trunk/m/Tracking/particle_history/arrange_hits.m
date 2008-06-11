## -*- texinfo -*-
## @deftypefn {Function File} {} arrange_hits(@var{particle_history})
## @deftypefnx {Function File} {} arrange_hits(@var{particle_history_array})
##
## arrange 'hit' field of @var{particle_history}
##
## if two arguments are given, append hit_history.
##
## @var{particle_history_array} is cell array of 'particle_history',
## 
## @end deftypefn

##== History
## 2008-03-29
## * initial implementaion

function result = arrange_hits(varargin)
  if (nargin > 1)
    result = varargin{1};
    particle_history_array = varargin{2};
  else
    result = struct;
    particle_history_array = varargin{1};
  endif

  if (!iscell(particle_history_array))
    particle_history_array = {particle_history_array};
  endif
  
  for n = 1:length(particle_history_array)
    a_particle_history = particle_history_array{n};
    for [val, key] = a_particle_history.hit
      if (length(val) > 0)
        if (!isfield(result, key) || isempty(result.(key)))
          result.(key) = struct("flags",[], "id", [], "n_rev", []...
                              , "h", [], "v", []);
        endif
        beg_rev = 1;        
#        if (isfield(a_particle_history, "beginning_revolution"))
#          beg_rev = a_particle_history.beginning_revolution;
#        endif
        result.(key) = arrange_hit_history(result.(key), val, beg_rev);
      else
        if (!isfield(result, key))
          result.(key) = {};
        endif
      endif
    endfor
  endfor
endfunction

function hits = arrange_hit_history(hits, hit_history, beg_rev)
  pmat = [];
  n_rev = [];
  for n = 1:length(hit_history)
    a_record = hit_history{n};
    np = columns(a_record.particles);
    pmat(:, end+1:end+np) = a_record.particles;
    hits.flags(:,end+1:end+np) = a_record.flags;
    hits.id(end+1:end+np) = a_record.id;
    n_rev(end+1:end+np) = repmat(a_record.n_rev,1,np);
  endfor
  x = [pmat(1,:);pmat(2,:)]';
  y = [pmat(4,:);pmat(5,:)]';
  np = rows(x);
  hits.h(end+1:end+np,:) = x;
  hits.v(end+1:end+np,:) = y;
  hits.n_rev(end+1:end+np) = n_rev + (beg_rev -1);
endfunction

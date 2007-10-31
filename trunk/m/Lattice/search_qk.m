## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} search_qk(@var{lattice_rec})
##
## @deftypefnx {Function File} {[@var{qfk}, @var{qdk}] =} search_qk(@var{tunex}, @var{tuney} [, @var{initial_qfk}, @var{initial_qdk}])
##
## Search and return qfk and qdk which cause tunes given as arguments.
##
## Arguemnt @var{lattice_rec} can have following fields.
##
## @table @code
## @item measured_tune.h
## @item measured_tune.v
##
## @item initial_qfk
## optional
## @item initial_qdk
## optional
## @end table
## 
## If nargout == 1, a structure is returned which have 'qfk' and 'qdk' as its fields.
##
## @end deftypefn

##== History
## 2007-10-18
## * derived from searckQValue
## * accept lattice structure
##
## 2006-09-28
## * assume vedge : 0

function varargout = search_qk(varargin)
  if (isstruct(varargin{1}))
    lattice_rec = varargin{1};
    tunex = lattice_rec.measured_tune.h;
    tuney = lattice_rec.measured_tune.v;
    switch (length(varargin))
      case (1)
        if (isfield(lattice_rec, "initial_qfk"))
          initialValues = [lattice_rec.initial_qfk, lattice_rec.initial_qdk];
        else
          #initialValues = [1.7833; 1.7249];
          initialValues = [1.3; 1.3];
          #initialValues = [0.5; 3];
        endif
        
      case (2)
        initialValues = varargin{2};
      case (3)
        initialValues = [varargin{2}; varargin{3}];
      otherwise
        error ("optional argument must be less than 2");
    endswitch
  else
    tunex = varargin{1};
    tuney = varargin{2};
    switch (length(varargin))
      case (2)
        #initialValues = [1.7833; 1.7249];
        initialValues = [1.3; 1.3];
        #initialValues = [0.5; 3];
      case (3)
        initialValues = varargin{3};
      case (4)
        initialValues = [varargin{3}; varargin{4}];
      otherwise
        error ("optional argument must be less than 2");
    endswitch
    
  endif
  
  
  stol=0.01; 
  #stol=0.0001; 
  niter=5;
  
  global verbose;
  verbose=1;
  F = @calc_tune;
  [f1, leasqrResults, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr ([1;2], [tunex; tuney], initialValues, F, stol, niter);
  
  if (nargout > 1)
    varargout = {leasqrResults(1), leasqrResults(2)};
  else
    varargout = {setfields(lattice_rec...
      , "qfk", leasqrResults(1), "qdk", leasqrResults(2))};
  endif
endfunction

function result = calc_tune(dummy, q_values)
  #allElements = buildWERCMatrix(qValues(1),qValues(2), 0);
  lattice_def = lattice_definition();
  all_elements = lattice_def(struct("qfk", q_values(1),"qdk", q_values(2)));
  lat_rec = process_lattice(all_elements);
  result = [lat_rec.tune.h; lat_rec.tune.v];
endfunction

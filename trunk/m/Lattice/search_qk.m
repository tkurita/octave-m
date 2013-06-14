## -*- texinfo -*-
## @deftypefn {Function File} {@var{lattice_rec} =} search_qk(@var{lattice_rec})
##
## @deftypefnx {Function File} {[@var{qfk}, @var{qdk}] =} search_qk([@var{tune_h}, @var{tune_v}, @var{beta_f}, ...], options)
##
## Search and return qfk and qdk and vedge which represents given tunes and beta functions.
##
## Arguemnt @var{lattice_rec} can have following fields.
##
## @table @code
## @item measured_tune.h
## @item measured_tune.v
## @item measured_beta.qf.h
## Optional
## @item measured_beta.qf.v
## Optional
## @item measured_beta.qd.h
## Optional
## @item measured_beta.qd.v
## Optional
## @end table
## 
## If one of beta functions are inclueded in the target values, "vedge" searching is activate.
##
## When only tunes are searched, "vedge" is not contained in the parameters.
##
## If nargout == 1, a structure is returned which have 'qfk' and 'qdk' as its fields.
##
## Required "pkg load optim".
## @end deftypefn

##== History
## 2013-06-14
## * load "optim"
##
## 2009-05-29
## * "use_vedge" option is required to include vedge as a fitting parameter.
## * tune parameters must not be required.
## 
## 2008-07-25
## * Suppoort beta functions for fitting values.
## * Drop support lattice_rec.initial_qfk and lattice_rec.initial_qdk.
##
## 2007-10-18
## * derived from searckQValue
## * accept lattice structure
##
## 2006-09-28
## * assume vedge : 0

function varargout = search_qk(farg, varargin)
  pkg load "optim"
  #disp("start search_qk")
  #value_names = {"tune_h", "tune_v"};
  global _qfd_ratio; # qfd/qfk
  _qfd_ratio = 0;
  
  if (isstruct(farg))
    value_names = {};
    target_values = [];
    lattice_rec = farg;
    if (isfield(lattice_rec, "measured_tune"))
      tune_rec = lattice_rec.measured_tune;
      if (isfield(tune_rec, "h"))
        value_names{end+1} = "tune_h";
        target_values(end+1) = tune_rec.h;
      endif
      if (isfield(tune_rec, "v"))
        value_names{end+1} = "tune_v";
        target_values(end+1) = tune_rec.v;
      endif
    endif
    
    if (isfield(lattice_rec, "measured_beta"))
      mbeta = lattice_rec.measured_beta;
      if (isfield(mbeta, "qf"))
        if (isfield(mbeta.qf, "h"))
          target_values(end+1) = mbeta.qf.h;
          value_names{end+1} = "beta_qf_h";
        endif
        if (isfield(mbeta.qf, "v"))
          target_values(end+1) = mbeta.qf.v;
          value_names{end+1} = "beta_qf_v";
        endif
      endif
      
      if (isfield(mbeta, "qd"))
        if (isfield(mbeta.qd, "h"))
          target_values(end+1) = mbeta.qd.h;
          value_names{end+1} = "beta_qd_h";
        endif
        if (isfield(mbeta.qd, "v"))
          target_values(end+1) = mbeta.qd.v;
          value_names{end+1} = "beta_qd_v";
        endif
      endif
    endif
    
    if (isfield(lattice_rec, "qfd_ratio"))
      _qfd_ratio = lattice_rec.qfd_ratio;
    endif
  else
    target_names = {"tune_h", "tune_v"};
    target_values = farg;    
  endif
  
  if (_qfd_ratio)
    initv = [1.3, 0];
  else
    initv = [1.3, 1.3];
  endif
  
  [initv, value_names, use_vedge] = get_properties(varargin, ...
                        {"initial", "value_names", "use_vedge"}, 
                        {initv, value_names, false});
  #if (length(target_values) > 2)
  if (use_vedge)
    initv(end+1) = 0;
  endif
  global _value_names;
  _value_names = value_names;
  
  stol=0.01; 
  #stol=0.0001; 
  niter=5;
  global verbose;
  verbose=1;
  F = @calc_tune;
#  [f1, leasqr_results, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
#  leasqr((1:length(target_values))', target_values', initv', F, stol, niter);
  [f1, leasqr_results, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
  leasqr((1:length(target_values))', target_values(:), initv(:), F, stol, niter);
  
  if (nargout > 1)
    #varargout = {leasqr_results(1), leasqr_results(2)};
    varargout = num2cell(leasqr_results);
  else
    if (_qfd_ratio)
      leasqr_results = [leasqr_results(1);
                        _qfd_ratio*leasqr_results(1); 
                        leasqr_results(2:end)];
    endif
    if (isstruct(farg))
      varargout = {setfields(lattice_rec, ...
                "qfk", leasqr_results(1), "qdk", leasqr_results(2))};
    else
      varargout = {struct("qfk", leasqr_results(1), "qdk", leasqr_results(2))};
    endif
    if (length(leasqr_results) > 2)
      varargout{1}.vedge = leasqr_results(3);
    endif
  endif
endfunction

function result = calc_tune(dummy, q_values)
  global _value_names;
  global _qfd_ratio;
  
  lattice_def = lattice_definition();
  # all_elements = lattice_def(struct("qfk", q_values(1),"qdk", q_values(2)));
  if (_qfd_ratio)
    q_values = [q_values(1); q_values(1)*_qfd_ratio; q_values(2:end)];
  endif
  all_elements = lattice_def(num2cell(q_values)'{:});
  lat_rec = process_lattice(all_elements);
  result = [];
  for n = 1:length(_value_names)
    switch _value_names{n}
      case "tune_h"
        result(end+1) = lat_rec.tune.h;
      case "tune_v"
        result(end+1) = lat_rec.tune.v;
      case "beta_qf_h"
        result(end+1) = element_with_name(lat_rec, "QF1").centerBeta.h;
      case "beta_qf_v"
        result(end+1) = element_with_name(lat_rec, "QF1").centerBeta.v;
      case "beta_qd_h"
        result(end+1) = element_with_name(lat_rec, "QD1").centerBeta.h;
      case "beta_qd_v"
        result(end+1) = element_with_name(lat_rec, "QD1").centerBeta.v;
    endswitch
  endfor
  result = result(:);
endfunction

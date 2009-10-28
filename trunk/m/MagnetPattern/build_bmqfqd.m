## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} build_bmqfqd(@var{arg})
##
## @end deftypefn

function [bmpat, qfpat, qdpat] = build_bmqfqd(pat_info)
  if (!nargin)
    print_usage();
  endif
  
  bmpattern = make_bm_pattern(pat_info);
  bmpat = trapz_pattern([0;bmpattern(:,1);2000],...
                        pat_info.bmbase, pat_info.bmtop);
  
  ## QF
  qfpat = trapz_pattern([0;bmpattern(:,1);2000],...
                        pat_info.qfbase, pat_info.qftop);
  fb_start = bmpattern(end/2,1);
  fb_end = bmpattern(end/2+1,1);
  qf_step1 = interpolate_step([fb_start, pat_info.qftop],...
                              [fb_start+50, pat_info.qfext]);
  qf_step2 = interpolate_step([fb_end-50, pat_info.qfext],...
                              [fb_end, pat_info.qftop]);
  
  qf_step_cells = {qf_step1(1,1), qf_step1(1,2), "spline";
                    qf_step1(2,1), qf_step1(2,2), "";
                    qf_step1(3,1), qf_step1(3,2), "";
                    qf_step1(4,1), qf_step1(4,2), "linear"
                    qf_step2(1,1), qf_step2(1,2), "spline";
                    qf_step2(2,1), qf_step2(2,2), "";
                    qf_step2(3,1), qf_step2(3,2), "";
                    qf_step2(4,1), qf_step2(4,2), 0};
  qfpatext = build_pattern(qf_step_cells);
  qfpat = {qfpat{1:(end-1)/2}, qfpatext{:}, qfpat{(end+1)/2+1:end}};
  
  ## QD
  t_qd = [0;bmpattern(:,1);2000];
  t_qd(2) += pat_info.qd_delay;
  t_qd(3) = t_qd(2)+pat_info.qd_smoothstep;
  t_qd(4) = t_qd(3)+pat_info.qd_smoothstep;
  qdpat = trapz_pattern(t_qd, pat_info.qdbase, pat_info.qdtop);  
endfunction

%!test
%! pat_info = struct("bmbase", 0.2950, "bmtop", 1.7232, "bmgrad", 0.002359734,...
%!       "smoothstep",  25, "tstart", 35, "tend", 1790, ...
%!       "qfbase", 0.0946, "qftop", 0.5513, "qfext", 0.5411,...
%!       "qdbase", 0.10115, "qdtop", 0.5897, "qd_delay", 2, "qd_smoothstep", 27);
%! [bmpat, qfpat, qdpat] = build_bmqfqd(pat_info)

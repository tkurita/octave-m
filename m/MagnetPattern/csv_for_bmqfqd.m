## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} csv_for_bmqdqf(@var{arg})
##
## @end deftypefn

##== History
## 2009-05-26
## * first implementation

function retval = csv_for_bmqfqd(pat_info, varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  opts = get_properties(varargin, {"output", "magnets"},...
                              {stdout, {"BM", "QF", "QD"}});
  is_open = false;
  if (ischar(opts.output))
      [fid , msg] = fopen(opts.output, "w");
      if (fid < 0)
        error(msg);
      endif
      is_open = true;
  elseif (isfid(opts.output))
    fid = opts.output;
  else
    error("output specification is invalid.");
  endif
  
  bmpattern = make_bm_pattern(pat_info);
  bpat_bm = trapz_pattern([0;bmpattern(:,1);2000],...
                        pat_info.bmbase, pat_info.bmtop);
  #fid = stdout;
  if (contain_str(opts.magnets, "BM"))
    fprintf(fid, "2,Pattern Data,\n#\nBl\n");
    csv_with_bpattern(bpat_bm,fid);
  endif
  ## QF
  if (contain_str(opts.magnets, "QF"))
    fprintf(fid, "#\nQfI\n");
    bpat_qf = trapz_pattern([0;bmpattern(:,1);2000],...
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
    bpat_qfext = build_pattern(qf_step_cells);
    csv_with_bpattern({bpat_qf{1:(end-1)/2}, bpat_qfext{:}, bpat_qf{(end+1)/2+1:end}}, fid);
  endif
  
  ## QD
  if (contain_str(opts.magnets, "QD"))
    fprintf(fid, "#\nQdI\n");
    t_qd = [0;bmpattern(:,1);2000];
    t_qd(2) += pat_info.qd_delay;
    t_qd(3) = t_qd(2)+pat_info.qd_smoothstep;
    t_qd(4) = t_qd(3)+pat_info.qd_smoothstep;
    bpat_qd = trapz_pattern(t_qd, pat_info.qdbase, pat_info.qdtop);
    csv_with_bpattern(bpat_qd, fid);
  endif
  
  if (is_open)
    fclose(fid);
  endif
endfunction

%!test
%! pat_info = struct("bmbase", 0.2950, "bmtop", 1.7232, "bmgrad", 0.002359734,...
%!       "smoothstep",  25, "tstart", 35, "tend", 1790, ...
%!       "qfbase", 0.0946, "qftop", 0.5513, "qfext", 0.5411,...
%!       "qdbase", 0.10115, "qdtop", 0.5897, "qd_delay", 2, "qd_smoothstep", 27);
%! csv_for_bmqfqd(pat_info, "magnets", {"QF","QD"})
%! #csv_for_bmqfqd(pat_info, "output", "hello.csv")

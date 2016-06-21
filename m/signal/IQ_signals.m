## -*- texinfo -*-
## @deftypefn {Function File} {@var{IQ} =} IQ_signals(@var{RF}, @var{LO})
## @deftypefnx {Function File} {@var{IQ} =} IQ_signals(..., "fc", @var{fc}, ....")
## Evaluate IQ signals
## @strong{Inputs}
## @table @var
## @item RF
## target signal
## @item LO
## carrier wave
## @end table
##
## @strong{Options}
## @table @code
## @item fc
## cutoff frequency of LPF in Hz.
## @item advance_RF
## @item advance_LO
## @end table
##
## @strong{Methods}
## @table @code
## @item LO
## @item RF
## @item t
## @item Iout
## @item Qout
## @item amp
## @item tan_phi
## @item cos_phi
## @item sin_phi
## @item phase
## @end table
##
## @end deftypefn

classdef IQ_signals < handle
  properties
    LO = [];
    RF = [];
    t = [];
    Iout = [];
    Qout = [];
    aux = struct();
  end
  methods
    function self = IQ_signals(RF, LO, varargin)
      opts = get_properties(varargin, {"fc", NA;
                                       "advance_RF", 0;
                                       "advance_LO", 0});
#      self.LO = LO;
#      self.RF = RF;
#      return
      pkg load signal;
      if (ischar(LO))
        LO_isf = isf_data(LO);
        RF_isf = isf_data(RF);
        LO_v = LO_isf.v;
        RF_v = RF_isf.v;
        ts = LO_isf.ts;
        t = LO_isf.t;
      else
        t = RF(:,1);
        ts = t(2) - t(1);
        LO_v = LO(:,2);
        RF_v = RF(:,2);
      endif
      if (opts.advance_RF > 0)
        ds = round(opts.advance_RF/ts)
        RF_v = RF_v(ds+1:end);
      endif
      if (opts.advance_LO > 0)
        ds = round(opts.advance_LO/ts);
        LO_v = LO_v(ds+1:end);
      endif
      if (length(LO_v) != length(RF_v)) 
        last_idx = min([length(LO_v), length(RF_v)]);
        RF_v = RF_v(1:last_idx);
        LO_v = LO_v(1:last_idx);
        t = t(1:last_idx);
      endif
      if (isna(opts.fc))
        ft_result = fourier(LO_v, ts, "window", "hamming");
        pkf = peak_freq(ft_result);
        filterorder = round(2/(ts*pkf));
        # filterorder の 移動平均のカットオフ周波数と
        # 同じカットオフ周波数を設定することにする。
        fc = 0.443/(filterorder*ts);
      else
        fc = opts.fc;
        filterorder = round(0.443/(fc*ts));
      endif
      printf("LPF cutoff : %f [Hz], order : %d \n", fc, filterorder);
      fc_normalized = 2*fc*ts;
      lpf = fir1(filterorder, 2*fc*ts);
      # IQ 信号
      Iout = filter(lpf, 1, LO_v.*RF_v);
      LO_hilbelt = imag(hilbert(LO_v));
      Qout = filter(lpf, 1, LO_hilbelt.*RF_v);
      # LPF による遅延の補正
      delay_correct = round(filterorder/2);
      self.Iout = Iout(1+delay_correct:end);
      self.Qout = Qout(1+delay_correct:end);
      self.t = t(1:end-delay_correct);
      self.RF = RF_v;
      self.LO = LO_v;
    endfunction
    
    function retval = amp(self)
      retval = 2*sqrt(self.Iout.^2 + self.Qout.^2);
    endfunction
    
    function retval = cos_phi(self)
      retval = self.Iout./(self.amp/2);
    endfunction

    function retval = tan_phi(self)
      retval = self.Qout./self.Iout;
    endfunction
    
    function retval = sin_phi(self)
      retval = self.Qout./(self.amp/2);
    endfunction

    function retval = phase(self, invfunc)
      if (nargin > 1)
        phasefunc = [invfunc(2:end), "_phi"];
        invfunc = str2func(invfunc);
      else
        invfunc = @atan;
        phasefunc = "tan_phi";
      endif
      retval = invfunc(self.(phasefunc));
    endfunction
    
    function self = set(self, prop, v)
      warning ("off", "Octave:classdef-to-struct", "local");
      s = struct(self);
      if isfield(s, prop)
        self.(prop) = v
      else
        self.aux.(prop) = v;
      endif
    endfunction
    
    function retval = get(self, prop)
      warning ("off", "Octave:classdef-to-struct", "local");
      s = struct(self);
      if isfield(s, prop)
        retval = self.(prop);
      else
        retval = self.aux.(prop);
      endif
    endfunction
    
  endmethods
endclassdef

%!test
%! func_name(x)

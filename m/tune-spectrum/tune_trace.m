## -- retval = func_name(arg1, arg2)
##  1. iqt2fft の csv 出力を読み込む
##  2. 設定した条件で peak search する。peak のトレンドをサーチする。
##     - 中心周波数とサイドバンド
##  3. peak search と speana データを重ねてプロットする。
##  4. tune を計算する。
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

classdef tune_trace < handle
  properties
    csvfile
    spectrumdata
    fwidth = NA
    starttime = NA
    endtime = NA
    frev = NA     # trace of revolution frequency
    lsb = NA      # trace of lower side band
    hsb = NA      # trace of higher side band
  endproperties

  methods
    ## Constructor
    function obj = tune_trace(argin)
      if ischar(argin)
        obj.csvfile = argin;
        obj.spectrumdata = load_spectrum_csv(argin);
      else
        obj.spectrumdata = argin;
      endif
    endfunction

    function trace = trace_peak(self, f, varargin)
      opts = get_properties(varargin ...
                            , {"fwidth", self.fwidth;
                               "starttime", self.starttime;
                               "endtime", self.endtime;
                               "skipfreq", []});
      if !isna(opts.fwidth); self.fwidth = opts.fwidth; endif
      if isna(opts.starttime)
        self.starttime = self.spectrumdata.ms(1);
      else
        self.starttime = opts.starttime;
      endif
      if isna(opts.endtime)
        self.endtime = self.spectrumdata.ms(end);
      else
        self.endtime = opts.endtime;
      endif
      if !isna(opts.skipfreq); self.skipfreq = opts.skipfreq; endif

      trace = trace_peak_spectrum(self.spectrumdata, f, self.fwidth ...
                                  , "starttime", self.starttime, "endtime", self.endtime);
    endfunction

    function trace = trace_frev(self, f, varargin)
      trace = self.trace_peak(f, varargin{:});
      self.frev = trace;
    endfunction

    function trace = trace_lsb(self, f, varargin)
      trace = self.trace_peak(f, varargin{:});
      self.lsb = trace;
    endfunction

    function trace = trace_hsb(self, f, varargin)
      trace = self.trace_peak(f, varargin{:});
      self.hsb = trace;
    endfunction

    function append_trace(self, trace, color)
      append_plot([trace.freq, trace.t], "-", "linewidth", 1, "color", color);
    endfunction

    function plot_spectrum(self)
      plot_spectrum(self.spectrumdata, "x", "MHz");
      append_trace(self, self.frev, "white");
      if isavailable(self.lsb)
        append_trace(self, self.lsb, "black");
      endif
      if isavailable(self.hsb)
        append_trace(self, self.hsb, "black");
      endif
    endfunction

    function tune = calc_tune(self, eq)
      df = NA;
      if isavailable(self.lsb)
        df = self.frev.freq - self.lsb.freq;
      endif
      if isavailable(self.hsb)
        dfh = self.hsb.freq - self.frev.freq;
        if length(df) > 1
          df = (df + dfh)/2;
        else
          df = dfh;
        endif
      endif
      tune = [self.frev.t, eq(df, self.frev.freq)];
    endfunction    
  endmethods
endclassdef


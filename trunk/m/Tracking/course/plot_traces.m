function result = plot_traces(trace_list, varargin)
  plot_args = {};
  opts = get_properties(varargin, {"color"}, {[1,0,0]});
  for n = 1:length(trace_list)
    plot_args{end+1} = trace_list{n};
    plot_args{end+1} = "-";
    plot_args{end+1} = "color";
    plot_args{end+1} = opts.color;
  end
  
  result = xyplot(plot_args{:});
end
  
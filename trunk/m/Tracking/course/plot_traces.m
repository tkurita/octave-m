function result = plot_traces(trace_list)
  plot_args = {};
  for n = 1:length(trace_list)
    plot_args{end+1} = trace_list{n};
    plot_args{end+1} = "-r";
  end
  
  result = xyplot(plot_args{:});
end
  
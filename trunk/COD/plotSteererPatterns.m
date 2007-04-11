## usage : plotSteererPatterns(timeLine, steererMat, steererNames)

function plotSteererPatterns(timeLine, steererMat, steererNames)
	plot_input = {};
	for i = 1:length(steererNames)
		plot_input = {plot_input{:}, timeLine, steererMat(:,i),["-@;",steererNames{i},";"]};
	endfor
	xlabel("time [msec]");
	ylabel("[A]");
	plot(plot_input{:});
endfunction
## useage : plotterm(termName)
##
## wrapper function to set terminal function of gnuplot

function plotterm(termName)
	eval (sprintf ("__gnuplot_set__ terminal %s;",termName));
endfunction

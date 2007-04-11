## Usage : plotLattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
##    Plot beta-function and dispersion.
##    Names of lattice elements shown on x-axis are assign by visibleLabes.

function plotLattice(allElements,betaFunction,dispersion,visibleLabels,titleText,insertComment)
  ##labels of name of elements on x axis
  #__gnuplot_raw__("unset label\n");
  text();
  thePosition = 0;
  for n = 1:length(allElements)
    theElement = allElements{n};
    xPosition = thePosition+(theElement.len/2);
    for n = 1:length(visibleLabels)
      visibleName = visibleLabels{n};
      findAns = findstr(theElement.name,visibleName,0);
      if (length(findAns) && findAns(1)==1)
        #eval(sprintf("gset label \"%s\" at %f,0 rotate by 90 font \"Helvetica,10\"", theElement.name, xPosition));
        eval(sprintf("__gnuplot_set__ label \"%s\" at %f,0 rotate by 90 font \"Helvetica\"", theElement.name, xPosition));
        break;
      endif
    end
    thePosition = thePosition + theElement.len;
  end
  
  ##plot
  eval(sprintf("__gnuplot_set__ label \"%s\" at graph 0.05,0.95",insertComment));
  #eval(sprintf("gset title \"%s\"",titleText));
  title(titleText);
  ylabel("dispersion,beta [m]");
  xlabel("Position [m]");
  xyplot(betaFunction.h, "-@;horizontal beta;", betaFunction.v, "-@;vertical beta;", dispersion, "-@;dispersion;");
endfunction
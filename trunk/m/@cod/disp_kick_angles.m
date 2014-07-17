## -*- texinfo -*-
## @deftypefn {Function File} disp_kick_angles(@var{cod}, ["unit", @var{unit}])
## print kick angles
## @strong{Inputs}
## @table @var
## @item cod
## COD Object
## @item 
## @end table
## 
## @seealso{disp_currents}
## @end deftypefn

##== History
## 2014-07-17
## * first implementation

function disp_kick_angles(cod_obj, varargin)
  unit_factor = 1;

  steererNames = cod_obj.kickers;
  steererValues = cod_obj.kick_angles;
  out_form = "%e";
  unit_str = "rad";
  n = 1;
  while (n <= length(varargin))
    a_option = varargin{n};
    n++;
    switch (a_option)
      case "unit"
        unit_str = varargin{n};
        switch (varargin{n})
          case "mrad"
            unit_factor = 1000;
          case "rad"
            unit_factor = 1;
          otherwise
            error([varargin{n}, " is unknown unit."]);
        endswitch
        n++;
      otherwise
        error([varargin{n}, " is unknown option."]);
    endswitch
  end

  for n = 1:length(steererNames)
    printf(["%s:",out_form," [%s]\n"], steererNames{n},...
                      steererValues(n)*unit_factor, unit_str);
  endfor
endfunction
  
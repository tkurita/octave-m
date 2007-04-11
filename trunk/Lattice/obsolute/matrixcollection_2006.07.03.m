1; #dummy, this file is a collection file of functions

##= function collection
##== calc initial dispersion
function eater = getDispersion(fullMatrix,cosmu)
	#initial dispersion function
	eater = (1/(2*(1-cosmu))) * [fullMatrix(1,3)+fullMatrix(1,2)*fullMatrix(2,3)-fullMatrix(2,2)*fullMatrix(1,3);
								fullMatrix(2,3)+fullMatrix(2,1)*fullMatrix(1,3)-fullMatrix(1,1)*fullMatrix(2,3)];
	eater = [eater;1];
endfunction

##== calc Twiss Parameter 
function twPcosMu = twissParameter(fullMatrix)
	cosmu = (fullMatrix(1,1)+fullMatrix(2,2))/2;

	if fullMatrix(1,2) >= 0
		sinmu = sqrt(1-cosmu^2);
	else
		sinmu = -sqrt(1-cosmu^2);
	endif

	beta0 = fullMatrix(1,2)/sinmu;
	
	alpha0 = (fullMatrix(1,1)-fullMatrix(2,2))/(2*sinmu);
	
	gamma0 = (1+alpha0^2)/beta0;
	
	twPcosMu.twp = [beta0;alpha0;gamma0];
	twPcosMu.cosmu = cosmu;
endfunction

##== pase advance
function phaseDelta = phaseAdvance(theMat,twPar)
	phaseDelta = atan(theMat(1,2)/(theMat(1,1)*twPar(1)-theMat(1,2)*twPar(2)));
endfunction

function phaseDelta = phaseAdvance_h(strElement,twPar) #obsolute
	theMat = strElement.mat_h;
	#twPar = strElement.twpar;
	phaseDelta = atan(theMat(1,2)/(theMat(1,1)*twPar(1)-theMat(1,2)*twPar(2)));
endfunction

function phaseDelta = phaseAdvance_v(strElement,twPar) #obsolute
	theMat = strElement.mat.v;
	#twPar = strElement.twpar;
	phaseDelta = atan(theMat(1,2)/(theMat(1,1)*twPar(1)-theMat(1,2)*twPar(2)));
endfunction

##== build matirx for twis parameter
function twpmat = twpMatrix(matrix)
  twpmat = [matrix(1,1)^2, -2*matrix(1,1)*matrix(1,2), matrix(1,2)^2;
			-matrix(2,1)*matrix(1,1), 1+2*matrix(1,2)*matrix(2,1), -matrix(1,2)*matrix(2,2);
			matrix(2,1)^2, -2*matrix(2,2)*matrix(2,1), matrix(2,2)^2];
endfunction

##= functions for aperture
function ductSize = ductAperture(theSize)
  switch length(theSize)
    case 1
      ductSize = struct("xman", theSize(1), "xmix", -theSize(1), "ymax", theSize(1), "ymin", -theSize(1));
    case 2
      ductSize = struct("xmax", theSize(1), "xmix", -theSize(1), "ymax", theSize(2), "ymin", -theSize(2));
    case 4
      ductSize = struct("xmax", theSize(1), "xmix", theSize(2), "ymax", theSize(3), "ymin", theSize(4));  
    otherwise
      theSize
      error("The matrix of duct size is invalid.");
  endswitch  
endfunction

##= drift tube
function matrix = DTmat(dl)
  ##drift tube の matrix
  ## dl : drift tube の長さ
  matrix = [1, dl, 0;
			0, 1, 0;
			0, 0, 1];
endfunction

function strDT = DT(dl,theName, varargin)
  ##== full
  strDT.len = dl; # 長さ
  strDT.k.h = 0;
  strDT.k.v = 0;
  strDT.name = theName; # 名前
  strDT.mat.h = DTmat(dl); # 横方向の matrix
  strDT.twmat.h = twpMatrix(strDT.mat.h);
  strDT.mat.v = strDT.mat.h; # 縦方向の matrix
  strDT.twmat.v = strDT.twmat.h;
  
  ##== half
  strDT.mat_half.h = DTmat(dl/2);
  strDT.twmat_half.h = twpMatrix(strDT.mat_half.h);
  strDT.mat_half.v = strDT.mat_half.h;
  strDT.twmat_half.v = strDT.twmat_half.h;
  
  if (length(varargin) != 0)
    strDT.duct = ductAperture(varargin{1});
  endif
endfunction

##= defocusing qudrople magnet

function matrix = QDmat(strQ)
  ## strQ mast have following fields
  ##  .qk -- focusing structure per length
  ##  .length or .efflen -- effective length of magnet
  len = fieldLength(strQ);
  sqk = sqrt(abs(qk));
  matrix = [
  cosh(sqk*len), (1/sqk)*sinh(sqk*len), 0;
  sqk*sinh(sqk*len), cosh(sqk*len), 0;
  0, 0, 1];  
endfunction

function strQD = QD(qk, ql, theName, varargin)
  hasEfflen = isstruct(ql);
  if (hasEfflen)
    strQD = ql;
  else
    strQD.len = ql;
  endif
  
  strQD.name = theName;
  
  ##== horizontal
  strQD.k.h = qk;
  strQD.mat.h = QDmat(qk, strQD.len);
  strQD.twmat.h = twpMatrix(strQD.mat.h);
  
  ##== vertical
  strQD.k.v = -qk;
  strQD.mat.v = QFmat(qk,ql);
  strQD.twmat.v = twpMatrix(strQD.mat.v);
  
  
  if (length(varargin) != 0)
    strQD.duct = ductAperture(varargin{1});
  endif
endfunction

##= focusing qudrople magnet
function matrix = QFmat(qk, ql)
  if (isstruct(ql))
    len = ql.efflen;
  else
    len = ql;
  endif
  sqk = sqrt(abs(qk));
  
  matrix = [
  cos(sqk*len), (1/sqk)*sin(sqk*len), 0;
  -sqk*sin(sqk*len), cos(sqk*len), 0;
  0, 0, 1];
  
  if (isstruct(ql))
    dl = (ql.efflen - ql.len)/2;
    matrix = DTmat(-dl) * matrix * DTmat(-dl);
  endif
endfunction

function strQF = QF(qk,ql,theName, varargin)
  if (isstruct(ql))
    strQF = ql;
  else
    strQF.len = ql;
  endif
  strQF.k.h = qk;
  strQF.k.v = -qk;
  strQF.name = theName;
  strQF.mat.h =  QFmat(qk, ql);
  strQF.twmat.h = twpMatrix(strQF.mat.h);
  strQF.mat.v =  QDmat(qk, ql);
  strQF.twmat.v = twpMatrix(strQF.mat.v);
  if (length(varargin) != 0)
    strQF.duct = ductAperture(varargin{1});
  endif
endfunction

##= bending magnet

##== edge effect of bending magnet
function matrix = BME_H(radius,edgeangle)
	matrix = [1, 0, 0;
			  tan(edgeangle)/radius, 1, 0;
			  0, 0, 1];
	#matrix = eye(3);
endfunction

function matrix = BME_V(radius,edgeangle)
	matrix = [1, 0, 0;
			  -tan(edgeangle)/radius, 1, 0;
			  0, 0, 1];
endfunction

function matrix = BME_V2(radius,edgeangle, b)
  #磁極端部でビーム進行方向に徐々に磁場が弱くなる効果を考慮
  matrix = [1, 0, 0;
  -tan(edgeangle)/radius + b/cos(edgeangle)/6/(radius^2), 1, 0;
  0, 0, 1];
endfunction

function matrix = BMHmat(radius,bmangle,edgeangle)
	edgematrix = BME_H(radius,edgeangle);
	bmmatrix = [cos(bmangle), radius*sin(bmangle), radius*(1-cos(bmangle));
			   -sin(bmangle)/radius, cos(bmangle), sin(bmangle);
			   0, 0, 1];
	matrix = edgematrix*bmmatrix*edgematrix;
endfunction

function strBM = BM(bmprop,theName,varargin)
  strBM = bmprop;
  strBM.name = theName;
  strBM.len = strBM.radius*strBM.bmangle;
  edgeangle = strBM.edgeangle;
  
  hasEfflen = isfield(strBM, "efflen"); #effective length info exists
  ##== horizontal
  ##=== full
  bmangle = strBM.bmangle;
  if (hasEfflen)
    radius = strBM.efflen/bmangle;
    dl = (strBM.efflen - strBM.len)/2;
  else
    radius = strBM.radius;
  endif
  strBM.edgeK.h = tan(edgeangle)/radius;
  
  strBM.mat.h = BMHmat(radius,bmangle,edgeangle);
  if (hasEfflen)
    strBM.mat.h = DTmat(-dl) * strBM.mat.h * DTmat(-dl);
  endif
  
  strBM.twmat.h = twpMatrix(strBM.mat.h);
  strBM.k.h = 1/radius^2;
  strBM.k.v = 0;
  
  ##=== half
  strBM.mat_half.h = BME_H(radius,edgeangle) * BMHmat(radius,bmangle/2,0);
  if (hasEfflen)
    strBM.mat_half.h = DTmat(-dl)*strBM.mat_half.h;
  endif
  strBM.twmat_half.h = twpMatrix(strBM.mat_half.h);
  
  ##== vertical
  ##=== full
  if (isfield(strBM, "vedge"))
    edgematrix = BME_V2(radius,edgeangle,strBM.vedge);
  else
    edgematrix = BME_V(radius,edgeangle);
  endif
  strBM.edgeK.v = edgematrix(2,1);
  
  if (hasEfflen)
    len = strBM.efflen;
  else
    len = strBM.len;
  endif
  
  strBM.mat.v = edgematrix*DTmat(len)*edgematrix;
  if (hasEfflen)
    strBM.mat.v = DTmat(-dl) * strBM.mat.v * DTmat(-dl);
  endif
  
  strBM.twmat.v = twpMatrix(strBM.mat.v);
  
  ##=== half
  strBM.mat_half.v = edgematrix*DTmat(len/2);
  if (hasEfflen)
    strBM.mat_half.v = DTmat(-dl) * strBM.mat_half.v;
  endif

  strBM.twmat_half.v = twpMatrix(strBM.mat_half.v);
  
  ##== apertue
  if (length(varargin) != 0)
    strBM.duct = ductAperture(varargin{1});
  endif
endfunction

## Usage : cod_list = cod_list_with_bpms(cod_rec)
##            or
##         cod_list = cod_list_with_bpms(cod_at_bpm, lattice);
##
## BPM の名前を key とした COD のデータ cod_rec.codAtBPM（structure）より、
## 位置とCODのリストに変換する。
##
##== Parameter
## * cod_rec (structure)
##      .codAtBPM -- data structure of COD at BPM [mm]
##                   field name give element name and the value is COD
##      .lattice -- output of calcLattice and it's family functions
##
## * lattice -- a cell array of elements
## * cod_at_bpm -- data structure of COD at BPM [mm]
##
##== Results
## * cod_list -- (:,1) postion of BPM
##                (:,2) COD given by the parameter codAtBPM

##== History
## 2007.10.02
## * renamed from cod_list_with_struct
## 2007.10.01
## * accept arguments of cod_at_bpm and lattice
## * rename from buildcod_list

function cod_list = cod_list_with_bpms(varargin)
  persistent a_lattice  = NA;
  
  if nargin > 1
    cod_at_bpm = varargin{1};
    a_lattice = varargin{2};
  else
    if isstruct(varargin{1})
      cod_at_bpm = varargin{1}.codAtBPM;
      a_lattice = varargin{1}.lattice;
    else
      error("The first arguments must be a structure.");
    endif
  end
  
  x = []; # COD
  s = []; # position
  for n = 1:length(a_lattice)
    latticeElement = a_lattice{n};
    elementName = latticeElement.name;
    if (isfield(cod_at_bpm, elementName))
      x = [x; cod_at_bpm.(elementName)];
      s = [s; latticeElement.centerPosition];
    endif
  endfor
  cod_list = [s,x];
endfunction
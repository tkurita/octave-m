## Usage : result = through_sx(sx_rec, particles)
##

##== History
## 2007-11-01
## * derived from sx_thin_kick
##
## 2007-10-03
## * renamed from sextupoleKickThin

function result = through_sx(sx_rec, particles)
  result = sx_rec.postmat * sx_thin_kick(sx_rec...
    , sx_rec.premat * particles);
endfunction
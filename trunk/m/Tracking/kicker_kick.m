##== History
## 2008-03-23
## * repmat is done in track_ring. やめた
##
## 2007-10-03
## * initial implementaion

function out_particles = kicker_kick(kicker_rec, in_particles)
  out_particles = kicker_rec.premat * in_particles;
#  out_particles = kicker_rec.postmat * (out_particles + kicker_rec.kickMat);
  out_particles = kicker_rec.postmat...
    * (out_particles + repmat(kicker_rec.kickVector, 1, columns(in_particles)));
endfunction

## kickMat (track_ring で生成）と repmat を使った実装の比較
## == kickMat を使った場合
## 144.50 sec
## 139.24 sec
## 119.67 sec
## 
## == repmat を使った場合
## 139.41 sec
## 122.66 sec
## 139.02 sec
##
## どちらも大差ない。
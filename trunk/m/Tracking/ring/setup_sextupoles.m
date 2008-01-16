##== History
## 2008.01.16
## * fix setuped element is not inserted into track_rec.lattice

function track_rec = setup_sextupoles(track_rec)
  all_elements = track_rec.lattice;

  if (isfield(track_rec, "sextupoles"))
    for n = 1:length(track_rec.sextupoles)
      sx_rec = track_rec.sextupoles{n};
      [an_elem, ind_elem] = element_with_name(all_elements, sx_rec.name);
      sx_rec = join_struct(an_elem, sx_rec);
      sx_rec = setup_sx(sx_rec, track_rec.brho);
      track_rec.lattice{ind_elem} = sx_rec;
      track_rec.sextupoles{n} = sx_rec;
    endfor
  else
    error("No sextupoles field.");
  endif
end
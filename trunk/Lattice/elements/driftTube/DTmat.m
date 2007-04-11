##= drift tube
## drift tube ‚Ì matrix
## dl : drift tube ‚Ì’·‚³

function matrix = DTmat(dl)
  matrix = [1, dl, 0;
			0, 1, 0;
			0, 0, 1];
endfunction
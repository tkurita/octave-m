##= drift tube
## drift tube �� matrix
## dl : drift tube �̒���

function matrix = DTmat(dl)
  matrix = [1, dl, 0;
			0, 1, 0;
			0, 0, 1];
endfunction
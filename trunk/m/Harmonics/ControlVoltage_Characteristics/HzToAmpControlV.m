## Usage : ctrlVList = HzToAmpControlV(hzList, A2_PM2)
##          �Q�{�����g�M���������u�̓d���ݒ�̎��g������
##
## = Parameters
## * hzlist -- [Hz]
## * A2_PM2 -- ���g�������f�[�^

function ctrlVList = HzToAmpControlV(hzList, A2_PM2)
  #global A2_PM2;
  fHz = A2_PM2(:,2);
  A2 = A2_PM2(:,3);
  [p,s,mu]=wpolyfit(fHz,A2,8);
  ctrlVList = polyval(p,(hzList-mu(1))./mu(2));
  #y1 = polyval(p,(fHz-mu(1))./mu(2));
  #plot(fHz,A2,"",fHz,y,"")
endfunction
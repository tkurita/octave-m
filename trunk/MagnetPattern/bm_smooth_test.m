## 2007-06-01 -- 消しても良い

bm_smooth
# bm_smooth =
# {
#   x =
# 
#      35
#      60
#      85
# 
#   P =
# 
#      0.00000  -0.00001   0.00000   0.34730
#     -0.00000   0.00007   0.00148   0.35720
# 
#   n =  2
#   k =  4
#   d =  1
# }
# 

polyderiv(bm_smooth.P(2,:))
# ans =
# 
#   -6.1773e-06   1.4256e-04   1.4850e-03
# 
polyval(bm_smooth.P(2,:), 85)
# ans = -0.26613

ppval(bm_smooth, [85])
# ans =  0.40670

85^3*bm_smooth.P(2,1)+85^2*bm_smooth.P(2,2)+85*bm_smooth.P(2,3)+bm_smooth.P(2,4)
# ans = -0.26613

pp = bm_smooth
xi = [85]

polyval(bm_smooth.P(2,:), 25)
# ans =  0.40670

polyval(polyderiv(bm_smooth.P(2,:)), 25)
# ans =  0.0011881

bm_pattern{3}
# ans =
# {
#   tPoints =
# 
#       85.000
#      607.100
# 
#   bPoints =
# 
#      0.40670
#      1.64730
# 
#   funcType = linear
#   grad =
# 
#      0.0011881   0.0011881
#      0.0011881   0.0011881
# 
# }
# 

polyval(polyderiv(polyderiv(bm_smooth.P(2,:))), 25)
# ans = -1.6631e-04

polyval(polyderiv(polyderiv(bm_smooth.P(1,:))), 0)
# ans = -2.3758e-05

gradient(bm_pattern{3}.bPoints)./gradient(bm_pattern{3}.tPoints)

##== 10MeV 入射の場合
Proton200MeVMagnet
plotMagnetPattern(

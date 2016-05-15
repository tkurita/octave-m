#useOwnTerm
1;
# 三光社の任意波形発生器用の電圧振幅パターン

Proton200MeVRFPattern
fs = 10e3; # サンプリング周波数 [Hz]
ts = 1/fs;

t_msec = (0:ts:2)*1e3;

v_pattern = rfvoltage_for_times( ...
  rfPattern_0200_10_180_280_400_50_20130603 , t_msec);

plot(v_pattern)

# -1msec
v_shifted = shift(v_pattern, -1e-3/ts);

#v_shifted = [zeros(1e-3/ts,1); v_pattern(:)]; 
plot(v_shifted, "-;shifted;", v_pattern, "-; original;");
v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_shifted));
plot(v_in_bit)
csvwrite("0200_10_180_280_400_50_20130603-1msec.csv", v_in_bit(:))

# -2msec
v_shifted = shift(v_pattern, -2e-3/ts);

#v_shifted = [zeros(1e-3/ts,1); v_pattern(:)]; 
plot(v_shifted, "-;shifted;", v_pattern, "-; original;");
v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_shifted));
plot(v_in_bit)
csvwrite("0200_10_180_280_400_50_20130603-2msec.csv", v_in_bit(:))

# -1.5msec
v_shifted = shift(v_pattern, -1.5e-3/ts);

#v_shifted = [zeros(1e-3/ts,1); v_pattern(:)]; 
plot(v_shifted, "-;shifted;", v_pattern, "-; original;");
v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_shifted));
plot(v_in_bit)
csvwrite("0200_10_180_280_400_50_20130603-1.5msec.csv", v_in_bit(:))

# -25msec
v_shifted = shift(v_pattern, -25e-3/ts);
plot(v_shifted, "-;shifted;", v_pattern, "-; original;");
v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_shifted));
plot(v_in_bit)
csvwrite("0200_10_180_280_400_50_20130603-25msec.csv", v_in_bit(:))

# 0msec
v_in_bit = bit_with_control_v(control_v_for_rf_amplitude(v_pattern));
plot(v_in_bit)
csvwrite("0200_10_180_280_400_50_20130603.csv", v_in_bit(:))